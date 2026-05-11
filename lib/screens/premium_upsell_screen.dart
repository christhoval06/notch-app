import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import 'package:notch_app/monetization/monetization_products.dart';
import 'package:notch_app/monetization/premium_feature.dart';
import 'package:notch_app/services/subscription_service.dart';
import 'package:notch_app/theme/color_scheme_semantics.dart';

class PremiumUpsellScreen extends StatefulWidget {
  final PremiumFeature? feature;

  const PremiumUpsellScreen({super.key, this.feature});

  @override
  State<PremiumUpsellScreen> createState() => _PremiumUpsellScreenState();
}

class _PremiumUpsellScreenState extends State<PremiumUpsellScreen> {
  final SubscriptionService _subscription = SubscriptionService();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _subscription,
      builder: (_, __) {
        if (_subscription.isPremium) {
          return _buildUnlocked(context);
        }
        return _buildPaywall(context);
      },
    );
  }

  Widget _buildUnlocked(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.verified, color: scheme.success, size: 52),
              const SizedBox(height: 16),
              Text(
                l10n.monetizationActiveTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: scheme.onSurface,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.monetizationActiveDescription,
                textAlign: TextAlign.center,
                style: TextStyle(color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.monetizationContinue),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaywall(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final products = _orderedProducts(_subscription.products);

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
              widget.feature == null
                  ? l10n.monetizationUnlockAll
                  : l10n.monetizationUnlockFeature(widget.feature!.title(l10n)),
              style: TextStyle(
                color: scheme.onSurface,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.feature?.description(l10n) ??
                  l10n.monetizationFallbackDescription,
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 20),
            if (_subscription.lastError != null)
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: scheme.error.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _subscription.lastError!,
                  style: TextStyle(color: scheme.error),
                ),
              ),
            if (_subscription.isLoadingProducts)
              const Center(child: CircularProgressIndicator()),
            if (!_subscription.isLoadingProducts && products.isEmpty)
              _buildUnavailableStore(),
            ...products.map(_buildProductCard),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _subscription.isPurchaseInProgress
                  ? null
                  : _subscription.restorePurchases,
              child: Text(l10n.monetizationRestorePurchases),
            ),
            TextButton(
              onPressed: _subscription.isPurchaseInProgress
                  ? null
                  : _subscription.presentPaywallIfNeeded,
              child: Text(l10n.monetizationOpenNativePaywall),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnavailableStore() {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Builder(
        builder: (context) => Text(
          AppLocalizations.of(context).monetizationStoreUnavailable,
          style: TextStyle(color: scheme.onSurfaceVariant),
        ),
      ),
    );
  }

  Widget _buildProductCard(SubscriptionPlan product) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final isBusy = _subscription.isPurchaseInProgress;
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
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
          Text(
            product.description,
            style: TextStyle(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isBusy ? null : () => _subscription.buy(product.id),
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

  List<SubscriptionPlan> _orderedProducts(List<SubscriptionPlan> products) {
    final byId = {for (final p in products) p.id: p};
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
