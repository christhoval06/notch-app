import 'package:flutter/foundation.dart';
import 'package:notch_app/core/constants/feature_flags.dart';
import 'package:notch_app/features/feature/premium/services/subscription_offerings_service.dart';
import 'package:notch_app/features/feature/premium/services/subscription_platform_service.dart';
import 'package:notch_app/features/feature/premium/services/subscription_runtime_state.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionInitRuntimeService {
  const SubscriptionInitRuntimeService._();

  static Future<void> init(
    SubscriptionRuntimeState state, {
    required void Function(String) log,
    required VoidCallback notify,
    required VoidCallback attachCustomerInfoListener,
    required Future<void> Function() loadLocalEntitlement,
    required Future<void> Function() refreshCustomerInfo,
    required Future<void> Function() loadProducts,
  }) async {
    if (state.initialized) return;
    state.initialized = true;
    log('init() start');
    await loadLocalEntitlement();
    if (!FeatureFlags.enableMonetizationInitialization) {
      log('init() skipped by feature flag');
      notify();
      return;
    }
    state.isStoreAvailable = SubscriptionPlatformService.isStoreAvailable;
    if (!state.isStoreAvailable) {
      state.lastError = 'RevenueCat is only available on iOS/Android.';
      log(state.lastError!);
      notify();
      return;
    }

    final apiKey = SubscriptionPlatformService.resolveApiKey();
    if (apiKey.isEmpty) {
      state.lastError =
          'RevenueCat API key missing. Pass RC_IOS_API_KEY / RC_ANDROID_API_KEY via --dart-define.';
      log(state.lastError!);
      notify();
      return;
    }

    try {
      await Purchases.setLogLevel(LogLevel.debug);
      await Purchases.configure(PurchasesConfiguration(apiKey));
      state.isConfigured = true;
      log('RevenueCat configured');
      attachCustomerInfoListener();
      await refreshCustomerInfo();
      await loadProducts();
    } catch (error) {
      state.lastError = 'RevenueCat init failed: $error';
      log(state.lastError!);
    }
    notify();
  }

  static Future<void> loadProducts(
    SubscriptionRuntimeState state, {
    required void Function(String) log,
    required VoidCallback notify,
  }) async {
    if (!FeatureFlags.revenueCatEnabled || !state.isConfigured) return;
    state.isLoadingProducts = true;
    state.lastError = null;
    notify();
    log('loadProducts() start');
    try {
      final result = await SubscriptionOfferingsService.load();
      state.plans = result.plans;
      state.packageByProductId
        ..clear()
        ..addAll(result.packageByProductId);
      log('loadProducts() done | plans=${state.plans.length}');
    } catch (error) {
      state.lastError = 'Unable to load RevenueCat offerings: $error';
      log(state.lastError!);
    } finally {
      state.isLoadingProducts = false;
      notify();
    }
  }
}
