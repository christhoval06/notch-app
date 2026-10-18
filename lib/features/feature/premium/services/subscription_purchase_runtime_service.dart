import 'package:flutter/foundation.dart';
import 'package:notch_app/core/constants/feature_flags.dart';
import 'package:notch_app/features/feature/premium/models/monetization_products.dart';
import 'package:notch_app/features/feature/premium/services/subscription_purchase_error_service.dart';
import 'package:notch_app/features/feature/premium/services/subscription_runtime_state.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

class SubscriptionPurchaseRuntimeService {
  const SubscriptionPurchaseRuntimeService._();

  static Future<bool> buy(
    SubscriptionRuntimeState state,
    String productId, {
    required void Function(String) log,
    required VoidCallback notify,
    required Future<void> Function(CustomerInfo info) applyCustomerInfo,
  }) async {
    if (!FeatureFlags.revenueCatEnabled || !state.isConfigured) return false;
    final package = state.packageByProductId[productId];
    if (package == null) {
      state.lastError = 'Package not found for product: $productId';
      notify();
      return false;
    }

    state.isPurchaseInProgress = true;
    state.lastError = null;
    notify();
    log('buy() start | productId=$productId');

    try {
      final canPay = await Purchases.canMakePayments();
      log('canMakePayments=$canPay');
      if (!canPay) {
        state.lastError =
            'Purchases are disabled on this device/account (canMakePayments=false).';
        log(state.lastError!);
        return false;
      }

      final info = await Purchases.purchasePackage(package);
      await applyCustomerInfo(info);
      log('buy() success | premium=${state.isPremium}');
      return true;
    } catch (error) {
      log('buy() exception type=${error.runtimeType}');
      if (SubscriptionPurchaseErrorService.isCancelled(error)) {
        log('buy() cancelled by StoreKit/Sandbox');
        state.lastError =
            'Purchase was cancelled by the App Store flow (Sandbox may auto-cancel). Please retry or use Restore Purchases.';
      } else {
        state.lastError = 'Purchase failed: $error';
        log(state.lastError!);
      }
      return false;
    } finally {
      state.isPurchaseInProgress = false;
      notify();
    }
  }

  static Future<void> restorePurchases(
    SubscriptionRuntimeState state, {
    required void Function(String) log,
    required VoidCallback notify,
    required Future<void> Function(CustomerInfo info) applyCustomerInfo,
  }) async {
    if (!FeatureFlags.revenueCatEnabled || !state.isConfigured) return;
    state.isPurchaseInProgress = true;
    state.lastError = null;
    notify();
    log('restorePurchases() start');
    try {
      final info = await Purchases.restorePurchases();
      await applyCustomerInfo(info);
      log('restorePurchases() done | premium=${state.isPremium}');
    } catch (error) {
      state.lastError = 'Restore failed: $error';
      log(state.lastError!);
    } finally {
      state.isPurchaseInProgress = false;
      notify();
    }
  }

  static Future<bool> presentPaywallIfNeeded(
    SubscriptionRuntimeState state, {
    required void Function(String) log,
    required VoidCallback notify,
    required Future<void> Function() refreshCustomerInfo,
  }) async {
    if (!FeatureFlags.revenueCatEnabled || !state.isConfigured) return false;
    log(
      'presentPaywallIfNeeded() for entitlement=${MonetizationProducts.entitlementNotchPro}',
    );
    try {
      final result = await RevenueCatUI.presentPaywallIfNeeded(
        MonetizationProducts.entitlementNotchPro,
      );
      log('paywall result: $result');
      await refreshCustomerInfo();
      return state.isPremium;
    } catch (error) {
      state.lastError = 'Paywall failed: $error';
      log(state.lastError!);
      notify();
      return false;
    }
  }

  static Future<void> presentCustomerCenter(
    SubscriptionRuntimeState state, {
    required void Function(String) log,
    required VoidCallback notify,
  }) async {
    if (!FeatureFlags.revenueCatEnabled || !state.isConfigured) return;
    log('presentCustomerCenter()');
    try {
      await RevenueCatUI.presentCustomerCenter();
    } catch (error) {
      state.lastError = 'Customer Center failed: $error';
      log(state.lastError!);
      notify();
    }
  }
}
