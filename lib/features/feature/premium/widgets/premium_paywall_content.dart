import 'package:flutter/material.dart';
import 'package:notch_app/core/theme/color_scheme_semantics.dart';
import 'package:notch_app/features/feature/premium/models/premium_feature.dart';
import 'package:notch_app/features/feature/premium/services/premium_products_order_service.dart';
import 'package:notch_app/features/feature/premium/services/subscription_service.dart';
import 'package:notch_app/features/feature/premium/widgets/premium_product_card.dart';
import 'package:notch_app/features/feature/premium/widgets/premium_store_unavailable.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class PremiumPaywallContent extends StatelessWidget {
  const PremiumPaywallContent({
    super.key,
    required this.feature,
    required this.subscription,
  });

  final PremiumFeature? feature;
  final SubscriptionService subscription;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final products = PremiumProductsOrderService.order(subscription.products);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(l10n.monetizationPremiumTitle),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Icon(Icons.lock_open_rounded, size: 40, color: scheme.warning),
            const SizedBox(height: 12),
            Text(
              feature == null
                  ? l10n.monetizationUnlockAll
                  : l10n.monetizationUnlockFeature(feature!.title(l10n)),
              style: TextStyle(
                color: scheme.onSurface,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              feature?.description(l10n) ?? l10n.monetizationFallbackDescription,
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 20),
            if (subscription.lastError != null)
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: scheme.error.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  subscription.lastError!,
                  style: TextStyle(color: scheme.error),
                ),
              ),
            if (subscription.isLoadingProducts)
              const Center(child: CircularProgressIndicator()),
            if (!subscription.isLoadingProducts && products.isEmpty)
              const PremiumStoreUnavailable(),
            ...products.map((product) {
              return PremiumProductCard(
                product: product,
                isBusy: subscription.isPurchaseInProgress,
                onBuy: () => subscription.buy(product.id),
              );
            }),
            const SizedBox(height: 8),
            TextButton(
              onPressed: subscription.isPurchaseInProgress
                  ? null
                  : subscription.restorePurchases,
              child: Text(l10n.monetizationRestorePurchases),
            ),
            TextButton(
              onPressed: subscription.isPurchaseInProgress
                  ? null
                  : subscription.presentPaywallIfNeeded,
              child: Text(l10n.monetizationOpenNativePaywall),
            ),
          ],
        ),
      ),
    );
  }
}
