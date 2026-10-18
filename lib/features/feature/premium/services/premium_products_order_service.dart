import 'package:notch_app/features/feature/premium/models/monetization_products.dart';
import 'package:notch_app/features/feature/premium/models/subscription_plan.dart';

class PremiumProductsOrderService {
  const PremiumProductsOrderService._();

  static List<SubscriptionPlan> order(List<SubscriptionPlan> products) {
    final byId = {for (final product in products) product.id: product};
    final ordered = <SubscriptionPlan>[];
    for (final id in MonetizationProducts.displayOrder) {
      final product = byId[id];
      if (product != null) ordered.add(product);
    }
    for (final product in products) {
      if (!MonetizationProducts.displayOrder.contains(product.id)) {
        ordered.add(product);
      }
    }
    return ordered;
  }
}
