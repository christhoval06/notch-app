import 'package:flutter/material.dart';
import 'package:notch_app/features/premium/models/premium_feature.dart';
import 'package:notch_app/features/premium/presentation/premium_upsell_screen.dart';
import 'package:notch_app/core/services/subscription_service.dart';

class PremiumAccess {
  // Temporary switch: keep guard wiring but bypass restrictions.
  static const bool _allowAllAccess = true;

  static bool hasAccess({
    required PremiumFeature feature,
    SubscriptionService? subscriptionService,
  }) {
    if (_allowAllAccess) return true;
    if (!feature.requiresPremium) return true;
    final service = subscriptionService ?? SubscriptionService();
    return service.isPremium;
  }

  static Future<void> guard({
    required BuildContext context,
    required PremiumFeature feature,
    required VoidCallback onAllowed,
    bool useBottomSheet = true,
  }) async {
    if (hasAccess(feature: feature)) {
      onAllowed();
      return;
    }

    final screen = PremiumUpsellScreen(feature: feature);

    if (useBottomSheet) {
      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => FractionallySizedBox(
          heightFactor: 0.88,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: screen,
          ),
        ),
      );
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }
}
