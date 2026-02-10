import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:notch_app/l10n/app_localizations.dart';

import '../utils/constants.dart';
import 'auth_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  double _currentPage = 0;
  final int _numPages = 4;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0;
      });
    });
  }

  void _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    bool isLastPage = _currentPage >= _numPages - 1;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _finishOnboarding,
                child: Text(
                  l10n.onboardingSkip,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),

            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  _OnboardingSlide(
                    icon: Icons.shield_sharp, // O Icons.fingerprint
                    title: l10n.onboardingSlide1Title,
                    description: l10n.onboardingSlide1Description,
                  ),
                  _OnboardingSlide(
                    icon: Icons.insights, // O Icons.explore
                    title: l10n.onboardingSlide2Title,
                    description: l10n.onboardingSlide2Description,
                  ),
                  _OnboardingSlide(
                    icon: Icons.trending_up, // O Icons.military_tech
                    title: l10n.onboardingSlide3Title,
                    description: l10n.onboardingSlide3Description,
                  ),
                  _FinalOnboardingSlide(
                    title: l10n.onboardingPinsTitle,
                    description: l10n.onboardingPinsDescription,
                    realPinTitle: l10n.onboardingRealPin,
                    realPinSubtitle: l10n.onboardingRealPinSubtitle,
                    panicPinTitle: l10n.onboardingPanicPin,
                    panicPinSubtitle: l10n.onboardingPanicPinSubtitle,
                  ),
                ],
              ),
            ),

            // Indicadores de Puntos y Botón de "Siguiente"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!isLastPage)
                    DotsIndicator(
                      dotsCount: 3,
                      position: _currentPage,
                      decorator: DotsDecorator(
                        color: Colors.grey[800]!,
                        activeColor: Colors.blueAccent,
                        size: const Size.square(9.0),
                        activeSize: const Size(18.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  isLastPage
                      ? ElevatedButton(
                          onPressed: _finishOnboarding,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                          ),
                          child: Text(
                            l10n.onboardingGoToApp,
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () => _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(15),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingSlide extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;

  const _OnboardingSlide({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  _OnboardingSlideState createState() => _OnboardingSlideState();
}

class _OnboardingSlideState extends State<_OnboardingSlide> {
  Timer? _hapticTimer;

  @override
  void initState() {
    super.initState();
    _startHapticFeedback();
  }

  void _startHapticFeedback() {
    const int hapticFrequency = 3; // Vibrate every 3 characters
    const Duration charAnimationSpeed = Duration(milliseconds: 50);
    Duration hapticTickDuration = Duration(
      milliseconds: charAnimationSpeed.inMilliseconds * hapticFrequency,
    );

    if (widget.description.isNotEmpty) {
      _hapticTimer = Timer.periodic(hapticTickDuration, (timer) {
        HapticFeedback.lightImpact();
      });

      // Stop the timer after the text animation is complete
      final int animationDuration =
          widget.description.length * charAnimationSpeed.inMilliseconds;
      Future.delayed(Duration(milliseconds: animationDuration), () {
        _hapticTimer?.cancel();
      });
    }
  }

  @override
  void dispose() {
    _hapticTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            widget.icon,
            size: 100,
            color: Colors.blueAccent.withOpacity(0.8),
          ),
          const SizedBox(height: 40),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'BebasNeue',
              fontSize: 36,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 20),

          AnimatedTextKit(
            isRepeatingAnimation: false,
            animatedTexts: [
              TypewriterAnimatedText(
                widget.description,
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  color: Colors.grey[400],
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

class _FinalOnboardingSlide extends StatelessWidget {
  final String title;
  final String description;
  final String realPinTitle;
  final String realPinSubtitle;
  final String panicPinTitle;
  final String panicPinSubtitle;

  const _FinalOnboardingSlide({
    Key? key,
    required this.title,
    required this.description,
    required this.realPinTitle,
    required this.realPinSubtitle,
    required this.panicPinTitle,
    required this.panicPinSubtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.vpn_key, size: 80, color: Colors.amberAccent),
          const SizedBox(height: 30),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 30),
          _buildPinCard(
            realPinTitle,
            DEFAULT_REAL_PIN,
            realPinSubtitle,
            Colors.blueAccent,
          ),
          const SizedBox(height: 15),
          _buildPinCard(
            panicPinTitle,
            DEFAULT_PANIC_PIN,
            panicPinSubtitle,
            Colors.orangeAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildPinCard(String title, String pin, String subtitle, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: Row(
        children: [
          Text(
            pin,
            style: TextStyle(
              fontFamily: 'monospace',
              color: color,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
