import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/auth/presentation/pages/auth_page.dart';
import 'package:notch_app/features/feature/onboarding/services/onboarding_completion_service.dart';
import 'package:notch_app/features/feature/onboarding/services/onboarding_slide_content_service.dart';
import 'package:notch_app/features/feature/onboarding/widgets/final_onboarding_slide.dart';
import 'package:notch_app/features/feature/onboarding/widgets/onboarding_footer.dart';
import 'package:notch_app/features/feature/onboarding/widgets/onboarding_slide.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final _pageController = PageController();
  var _currentPage = 0.0;
  static const _numPages = 4;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() => _currentPage = _pageController.page ?? 0);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    await OnboardingCompletionService.complete();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => AuthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final slides = OnboardingSlideContentService.build(l10n);
    final isLastPage = _currentPage >= _numPages - 1;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _finishOnboarding,
                child: Text(l10n.onboardingSkip),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  ...slides.map((slide) => OnboardingSlide(content: slide)),
                  const FinalOnboardingSlide(),
                ],
              ),
            ),
            OnboardingFooter(
              currentPage: _currentPage,
              isLastPage: isLastPage,
              onNext: () => _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              ),
              onFinish: _finishOnboarding,
            ),
          ],
        ),
      ),
    );
  }
}
