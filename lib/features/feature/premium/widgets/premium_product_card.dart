import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/premium/models/monetization_products.dart';
import 'package:notch_app/features/feature/premium/models/subscription_plan.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class PremiumProductCard extends StatelessWidget {
  const PremiumProductCard({
    super.key,
    required this.product,
    required this.isBusy,
    required this.onBuy,
  });

  final SubscriptionPlan product;
  final bool isBusy;
  final VoidCallback onBuy;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final isPrimary = product.id == MonetizationProducts.yearly;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isPrimary ? scheme.primary : scheme.outlineVariant,
          width: isPrimary ? 1.4 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  product.title,
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (isPrimary)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    l10n.monetizationRecommended,
                    style: TextStyle(color: scheme.primary, fontSize: 12),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(product.description, style: TextStyle(color: scheme.onSurfaceVariant)),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isBusy ? null : onBuy,
              child: isBusy
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.monetizationContinueWithPrice(product.price)),
            ),
          ),
        ],
      ),
    );
  }
}
