import 'package:notch_app/features/feature/premium/models/subscription_plan.dart';
import 'package:notch_app/features/feature/premium/services/premium_products_order_service.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionOfferingsResult {
  const SubscriptionOfferingsResult({
    required this.plans,
    required this.packageByProductId,
  });

  final List<SubscriptionPlan> plans;
  final Map<String, Package> packageByProductId;
}

class SubscriptionOfferingsService {
  const SubscriptionOfferingsService._();

  static Future<SubscriptionOfferingsResult> load() async {
    final offerings = await Purchases.getOfferings();
    final current = offerings.current;
    final packageByProductId = <String, Package>{};
    final plans = <SubscriptionPlan>[];

    if (current != null) {
      for (final pkg in current.availablePackages) {
        final product = pkg.storeProduct;
        packageByProductId[product.identifier] = pkg;
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

    return SubscriptionOfferingsResult(
      plans: PremiumProductsOrderService.order(plans),
      packageByProductId: packageByProductId,
    );
  }
}
