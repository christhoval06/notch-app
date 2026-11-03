import 'package:flutter/material.dart';
import 'package:notch_app/core/constants/landing_config.dart';
import 'package:notch_app/features/landing/widgets/landing_phone.dart';

class LandingHeroGallery extends StatelessWidget {
  const LandingHeroGallery({super.key});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final width = (constraints.maxWidth / 3.5).clamp(75.0, 245.0);
      return SizedBox(
        height: width * 2.45,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: width * .2),
                child: LandingPhone(
                  asset: LandingConfig.homeScreen,
                  width: width,
                  angle: -.085,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: LandingPhone(
                  asset: LandingConfig.loggerScreen,
                  width: width,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: width * .2),
                child: LandingPhone(
                  asset: LandingConfig.trophyScreen,
                  width: width,
                  angle: .085,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
