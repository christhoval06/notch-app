import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:notch_app/core/configs/feature_flags.dart';
import 'package:notch_app/features/feature/premium/models/monetization_products.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionPlan {
  final String id;
  final String title;
  final String description;
  final String price;

  const SubscriptionPlan({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
  });
}

class SubscriptionService extends ChangeNotifier {
  SubscriptionService._internal();

  static final SubscriptionService _instance = SubscriptionService._internal();
  factory SubscriptionService() => _instance;

  static const _premiumFlagKey = 'premium_unlocked';
  // Public SDK keys are safe to embed, but prefer --dart-define for env-specific values.
  static const _defaultIosApiKey = 'test_MhwLuKSQtKScPNnZEATCgAYpKOs';
  static const _defaultAndroidApiKey = 'test_MhwLuKSQtKScPNnZEATCgAYpKOs';

  bool _initialized = false;
  bool _isConfigured = false;
  bool _customerInfoListenerAttached = false;
  bool _isPremium = false;
  bool _isStoreAvailable = false;
  bool _isLoadingProducts = false;
  bool _isPurchaseInProgress = false;
  String? _lastError;

  List<SubscriptionPlan> _plans = const [];
  final Map<String, Package> _packageByProductId = {};

  bool get isPremium => _isPremium;
  bool get isStoreAvailable => _isStoreAvailable;
  bool get isLoadingProducts => _isLoadingProducts;
  bool get isPurchaseInProgress => _isPurchaseInProgress;
  String? get lastError => _lastError;
  List<SubscriptionPlan> get products => List.unmodifiable(_plans);
  bool get hasProducts => _plans.isNotEmpty;

  void _log(String message) {
    debugPrint('[RC][SubscriptionService] $message');
  }

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    _log('init() start');

    await _loadLocalEntitlement();
    if (!FeatureFlags.enableMonetizationInitialization) {
      _log('init() skipped by feature flag');
      notifyListeners();
      return;
    }
    _isStoreAvailable = Platform.isIOS || Platform.isAndroid;
    if (!_isStoreAvailable) {
      _lastError = 'RevenueCat is only available on iOS/Android.';
      _log(_lastError!);
      notifyListeners();
      return;
    }

    final apiKey = Platform.isIOS
        ? const String.fromEnvironment(
            'RC_IOS_API_KEY',
            defaultValue: _defaultIosApiKey,
          )
        : const String.fromEnvironment(
            'RC_ANDROID_API_KEY',
            defaultValue: _defaultAndroidApiKey,
          );

    if (apiKey.isEmpty) {
      _lastError =
          'RevenueCat API key missing. Pass RC_IOS_API_KEY / RC_ANDROID_API_KEY via --dart-define.';
      _log(_lastError!);
      notifyListeners();
      return;
    }

    try {
      await Purchases.setLogLevel(LogLevel.debug);
      await Purchases.configure(PurchasesConfiguration(apiKey));
      _isConfigured = true;
      _log('RevenueCat configured');
      _attachCustomerInfoListener();

      await _refreshCustomerInfo();
      await loadProducts();
    } catch (e) {
      _lastError = 'RevenueCat init failed: $e';
      _log(_lastError!);
    }

    notifyListeners();
  }

  Future<void> loadProducts() async {
    if (!_isConfigured) return;
    _isLoadingProducts = true;
    _lastError = null;
    notifyListeners();
    _log('loadProducts() start');

    try {
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;
      _packageByProductId.clear();
      final plans = <SubscriptionPlan>[];

      if (current != null) {
        for (final pkg in current.availablePackages) {
          final product = pkg.storeProduct;
          _packageByProductId[product.identifier] = pkg;
          plans.add(
            SubscriptionPlan(
              id: product.identifier,
              title: product.title,
              description: product.description,
              price: product.priceString,
            ),
          );
        }
      }

      _plans = _orderPlans(plans);
      _log('loadProducts() done | plans=${_plans.length}');
    } catch (e) {
      _lastError = 'Unable to load RevenueCat offerings: $e';
      _log(_lastError!);
    } finally {
      _isLoadingProducts = false;
      notifyListeners();
    }
  }

  Future<bool> buy(String productId) async {
    if (!_isConfigured) return false;
    final package = _packageByProductId[productId];
    if (package == null) {
      _lastError = 'Package not found for product: $productId';
      notifyListeners();
      return false;
    }

    _isPurchaseInProgress = true;
    _lastError = null;
    notifyListeners();
    _log('buy() start | productId=$productId');

    try {
      final canPay = await Purchases.canMakePayments();
      _log('canMakePayments=$canPay');
      if (!canPay) {
        _lastError =
            'Purchases are disabled on this device/account (canMakePayments=false).';
        _log(_lastError!);
        return false;
      }

      final info = await Purchases.purchasePackage(package);
      await _applyCustomerInfo(info);
      _log('buy() success | premium=$_isPremium');
      return true;
    } catch (e) {
      final isCancelled = _isPurchaseCancelledError(e);
      _log('buy() exception type=${e.runtimeType}');
      if (e is PlatformException) {
        _log('buy() platform code=${e.code}');
        _log('buy() platform message=${e.message}');
        _log('buy() platform details=${e.details}');
      }
      if (isCancelled) {
        _log('buy() cancelled by StoreKit/Sandbox');
        _lastError =
            'Purchase was cancelled by the App Store flow (Sandbox may auto-cancel). Please retry or use Restore Purchases.';
      } else {
        _lastError = 'Purchase failed: $e';
        _log(_lastError!);
      }
      return false;
    } finally {
      _isPurchaseInProgress = false;
      notifyListeners();
    }
  }

  Future<void> restorePurchases() async {
    if (!_isConfigured) return;

    _isPurchaseInProgress = true;
    _lastError = null;
    notifyListeners();
    _log('restorePurchases() start');

    try {
      final info = await Purchases.restorePurchases();
      await _applyCustomerInfo(info);
      _log('restorePurchases() done | premium=$_isPremium');
    } catch (e) {
      _lastError = 'Restore failed: $e';
      _log(_lastError!);
    } finally {
      _isPurchaseInProgress = false;
      notifyListeners();
    }
  }

  Future<void> _refreshCustomerInfo() async {
    try {
      final info = await Purchases.getCustomerInfo();
      await _applyCustomerInfo(info);
      _log('customer info refreshed | premium=$_isPremium');
    } catch (e) {
      _lastError = 'Unable to fetch customer info: $e';
      _log(_lastError!);
    }
  }

  Future<void> _applyCustomerInfo(CustomerInfo info) async {
    if (FeatureFlags.forcePremiumByDefault) {
      await _setPremium(true);
      return;
    }
    final entitlement = info.entitlements.active[MonetizationProducts.entitlementNotchPro];
    final premium = entitlement != null;
    await _setPremium(premium);
  }

  void _attachCustomerInfoListener() {
    if (_customerInfoListenerAttached) return;
    Purchases.addCustomerInfoUpdateListener((customerInfo) async {
      _log('customerInfo update received');
      await _applyCustomerInfo(customerInfo);
      notifyListeners();
    });
    _customerInfoListenerAttached = true;
  }

  Future<bool> presentPaywallIfNeeded() async {
    if (!_isConfigured) return false;
    _log(
      'presentPaywallIfNeeded() for entitlement=${MonetizationProducts.entitlementNotchPro}',
    );
    try {
      final result = await RevenueCatUI.presentPaywallIfNeeded(
        MonetizationProducts.entitlementNotchPro,
      );
      _log('paywall result: $result');
      await _refreshCustomerInfo();
      return _isPremium;
    } catch (e) {
      _lastError = 'Paywall failed: $e';
      _log(_lastError!);
      notifyListeners();
      return false;
    }
  }

  Future<void> presentCustomerCenter() async {
    if (!_isConfigured) return;
    _log('presentCustomerCenter()');
    try {
      await RevenueCatUI.presentCustomerCenter();
    } catch (e) {
      _lastError = 'Customer Center failed: $e';
      _log(_lastError!);
      notifyListeners();
    }
  }

  Future<void> _loadLocalEntitlement() async {
    if (FeatureFlags.forcePremiumByDefault) {
      _isPremium = true;
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    _isPremium = prefs.getBool(_premiumFlagKey) ?? false;
  }

  Future<void> _setPremium(bool value) async {
    _isPremium = FeatureFlags.forcePremiumByDefault ? true : value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_premiumFlagKey, _isPremium);
  }

  List<SubscriptionPlan> _orderPlans(List<SubscriptionPlan> plans) {
    final byId = {for (final p in plans) p.id: p};
    final ordered = <SubscriptionPlan>[];
    for (final id in MonetizationProducts.displayOrder) {
      final plan = byId[id];
      if (plan != null) ordered.add(plan);
    }
    for (final p in plans) {
      if (!MonetizationProducts.displayOrder.contains(p.id)) {
        ordered.add(p);
      }
    }
    return ordered;
  }

  bool _isPurchaseCancelledError(Object e) {
    if (e is PlatformException) {
      final details = e.details;
      if (details is Map) {
        final userCancelled = details['userCancelled'];
        final readableCode = details['readable_error_code'] ??
            details['readableErrorCode'];
        if (userCancelled == true) return true;
        if (readableCode == 'PURCHASE_CANCELLED') return true;
      }
    }

    if (e is PurchasesErrorCode) {
      return e == PurchasesErrorCode.purchaseCancelledError;
    }

    final message = e.toString();
    return message.contains('PURCHASE_CANCELLED') ||
        message.contains('userCancelled: true') ||
        message.contains('purchaseCancelledError');
  }
}
