import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notch_app/features/feature/onboarding/services/onboarding_slide_content_service.dart';

class OnboardingSlide extends StatefulWidget {
  const OnboardingSlide({super.key, required this.content});

  final OnboardingSlideContent content;

  @override
  State<OnboardingSlide> createState() => _OnboardingSlideState();
}

class _OnboardingSlideState extends State<OnboardingSlide> {
  Timer? _hapticTimer;

  @override
  void initState() {
    super.initState();
    _startHapticFeedback();
  }

  void _startHapticFeedback() {
    const hapticFrequency = 3;
    const charAnimationSpeed = Duration(milliseconds: 50);
    final tickDuration = Duration(
      milliseconds: charAnimationSpeed.inMilliseconds * hapticFrequency,
    );
    if (widget.content.description.isEmpty) return;
    _hapticTimer = Timer.periodic(tickDuration, (_) {
      HapticFeedback.lightImpact();
    });
    final animationDuration =
        widget.content.description.length * charAnimationSpeed.inMilliseconds;
    Future.delayed(Duration(milliseconds: animationDuration), () {
      _hapticTimer?.cancel();
    });
  }

  @override
  void dispose() {
    _hapticTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            widget.content.icon,
            size: 100,
            color: scheme.primary.withValues(alpha: 0.8),
          ),
          const SizedBox(height: 40),
          Text(
            widget.content.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'BebasNeue',
              fontSize: 36,
              color: scheme.onSurface,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 20),
          AnimatedTextKit(
            isRepeatingAnimation: false,
            animatedTexts: [
              TypewriterAnimatedText(
                widget.content.description,
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  color: scheme.onSurfaceVariant,
                  fontSize: 16,
                  height: 1.5,
                ),
                speed: const Duration(milliseconds: 50),
                cursor: '|',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
