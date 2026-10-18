import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/premium/models/premium_feature.dart';
import 'package:notch_app/features/feature/premium/widgets/premium_upsell_view.dart';

class PremiumUpsellScreen extends StatelessWidget {
  const PremiumUpsellScreen({super.key, this.feature});

  final PremiumFeature? feature;

  @override
  Widget build(BuildContext context) {
    return PremiumUpsellView(feature: feature);
  }
}
