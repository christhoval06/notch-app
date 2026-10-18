import 'package:flutter/foundation.dart';
import 'package:notch_app/features/feature/premium/models/monetization_products.dart';
import 'package:notch_app/features/feature/premium/models/subscription_plan.dart';
import 'package:notch_app/features/feature/premium/services/subscription_customer_info_service.dart';
import 'package:notch_app/features/feature/premium/services/subscription_init_runtime_service.dart';
import 'package:notch_app/features/feature/premium/services/subscription_local_cache_service.dart';
import 'package:notch_app/features/feature/premium/services/subscription_purchase_runtime_service.dart';
import 'package:notch_app/features/feature/premium/services/subscription_runtime_state.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionService extends ChangeNotifier {
  SubscriptionService._internal();

  static final SubscriptionService _instance = SubscriptionService._internal();
  factory SubscriptionService() => _instance;

  final _state = SubscriptionRuntimeState();

  bool get isPremium => _state.isPremium;
  bool get isStoreAvailable => _state.isStoreAvailable;
  bool get isLoadingProducts => _state.isLoadingProducts;
  bool get isPurchaseInProgress => _state.isPurchaseInProgress;
  String? get lastError => _state.lastError;
  List<SubscriptionPlan> get products => List.unmodifiable(_state.plans);
  bool get hasProducts => _state.plans.isNotEmpty;

  void _log(String message) {
    debugPrint('[RC][SubscriptionService] $message');
  }

  Future<void> init() {
    return SubscriptionInitRuntimeService.init(
      _state,
      log: _log,
      notify: notifyListeners,
      attachCustomerInfoListener: _attachCustomerInfoListener,
      loadLocalEntitlement: _loadLocalEntitlement,
      refreshCustomerInfo: _refreshCustomerInfo,
      loadProducts: loadProducts,
    );
  }

  Future<void> loadProducts() {
    return SubscriptionInitRuntimeService.loadProducts(
      _state,
      log: _log,
      notify: notifyListeners,
    );
  }

  Future<bool> buy(String productId) {
    return SubscriptionPurchaseRuntimeService.buy(
      _state,
      productId,
      log: _log,
      notify: notifyListeners,
      applyCustomerInfo: _applyCustomerInfo,
    );
  }

  Future<void> restorePurchases() {
    return SubscriptionPurchaseRuntimeService.restorePurchases(
      _state,
      log: _log,
      notify: notifyListeners,
      applyCustomerInfo: _applyCustomerInfo,
    );
  }

  Future<bool> presentPaywallIfNeeded() {
    return SubscriptionPurchaseRuntimeService.presentPaywallIfNeeded(
      _state,
      log: _log,
      notify: notifyListeners,
      refreshCustomerInfo: _refreshCustomerInfo,
    );
  }

  Future<void> presentCustomerCenter() {
    return SubscriptionPurchaseRuntimeService.presentCustomerCenter(
      _state,
      log: _log,
      notify: notifyListeners,
    );
  }

  Future<void> _loadLocalEntitlement() async {
    _state.isPremium = await SubscriptionLocalCacheService.loadPremium();
  }

  Future<void> _refreshCustomerInfo() async {
    try {
      final info = await Purchases.getCustomerInfo();
      await _applyCustomerInfo(info);
      _log('customer info refreshed | premium=${_state.isPremium}');
    } catch (error) {
      _state.lastError = 'Unable to fetch customer info: $error';
      _log(_state.lastError!);
    }
  }

  Future<void> _applyCustomerInfo(CustomerInfo info) async {
    _state.isPremium = SubscriptionCustomerInfoService.isPremium(info);
    await SubscriptionLocalCacheService.savePremium(_state.isPremium);
  }

  void _attachCustomerInfoListener() {
    if (_state.customerInfoListenerAttached) return;
    Purchases.addCustomerInfoUpdateListener((customerInfo) async {
      _log(
        'customerInfo update received for ${MonetizationProducts.entitlementNotchPro}',
      );
      await _applyCustomerInfo(customerInfo);
      notifyListeners();
    });
    _state.customerInfoListenerAttached = true;
  }
}
