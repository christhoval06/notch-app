import 'package:notch_app/core/constants/feature_flags.dart';
import 'package:notch_app/features/feature/premium/models/monetization_products.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionCustomerInfoService {
  const SubscriptionCustomerInfoService._();

  static bool isPremium(CustomerInfo info) {
    if (FeatureFlags.forcePremiumByDefault) return true;
    return info.entitlements.active[MonetizationProducts.entitlementNotchPro] !=
        null;
  }
}
