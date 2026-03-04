class MonetizationProducts {
  static const String monthly = 'notch_premium__monthly';
  static const String yearly = 'notch_premium__yearly';
  static const String lifetime = 'notch_premium_lifetime';
  // RevenueCat entitlement identifier (display name can be "Notch Pro").
  static const String entitlementNotchPro = 'notch_pro';

  static const Set<String> allProductIds = {monthly, yearly, lifetime};

  static const List<String> displayOrder = [yearly, monthly, lifetime];
}
