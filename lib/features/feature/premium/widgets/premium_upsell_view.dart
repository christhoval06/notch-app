import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/premium/models/premium_feature.dart';
import 'package:notch_app/features/feature/premium/services/subscription_service.dart';
import 'package:notch_app/features/feature/premium/widgets/premium_paywall_content.dart';
import 'package:notch_app/features/feature/premium/widgets/premium_unlocked_content.dart';

class PremiumUpsellView extends StatefulWidget {
  const PremiumUpsellView({super.key, required this.feature});

  final PremiumFeature? feature;

  @override
  State<PremiumUpsellView> createState() => _PremiumUpsellViewState();
}

class _PremiumUpsellViewState extends State<PremiumUpsellView> {
  final _subscription = SubscriptionService();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _subscription,
      builder: (_, _) {
        if (_subscription.isPremium) {
          return const PremiumUnlockedContent();
        }
        return PremiumPaywallContent(
          feature: widget.feature,
          subscription: _subscription,
        );
      },
    );
  }
}
