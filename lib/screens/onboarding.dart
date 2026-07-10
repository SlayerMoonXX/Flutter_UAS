import 'dart:async';

import 'package:flutter/material.dart';

import 'login_page.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  static const List<String> _backgroundImages = [
    'assets/png/mrkim.png',
    'assets/png/lesson.png',
    'assets/png/avatar.png',
  ];

  static const List<String> _slideTitles = [
    'Watch from the front row.',
    'Unlock your next favorite film.',
    'Stream the night your way.',
  ];

  static const List<String> _slideDescriptions = [
    'Step into a premium cinema mood with bold premieres and a clean, immersive viewing experience.',
    'Browse curated titles, fresh releases, and high-energy action picks made for movie lovers.',
    'Pick a film, relax, and let the background do the talking with a cinematic glow.',
  ];

  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted || !_pageController.hasClients) return;

      final nextIndex = (_currentIndex + 1) % _backgroundImages.length;
      _pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral.base,
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                if (!mounted) return;
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: _backgroundImages.length,
              itemBuilder: (context, index) {
                return _BackgroundSlide(imagePath: _backgroundImages[index]);
              },
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.35),
                    Colors.black.withValues(alpha: 0.60),
                    Colors.black.withValues(alpha: 0.96),
                  ],
                  stops: const [0.0, 0.52, 1.0],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Spacer(flex: 7),
                  Text(
                    _slideTitles[_currentIndex],
                    textAlign: TextAlign.center,
                    style: AppTypography.headlineLg.copyWith(
                      color: AppColors.neutral.onBase,
                      fontWeight: FontWeight.w700,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    _slideDescriptions[_currentIndex],
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyMd.copyWith(
                      color: AppColors.neutral.onMuted,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _backgroundImages.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: _IndicatorDot(active: index == _currentIndex),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brand.primary,
                        foregroundColor: AppColors.brand.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        'LOGIN',
                        style: AppTypography.labelLg.copyWith(
                          color: AppColors.brand.onPrimary,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      'REGISTER',
                      style: AppTypography.labelLg.copyWith(
                        color: AppColors.neutral.onBase,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundSlide extends StatelessWidget {
  const _BackgroundSlide({required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
          alignment: Alignment.center,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.neutral.surface, AppColors.neutral.base],
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.movie,
                  size: 64,
                  color: AppColors.neutral.onMuted,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _IndicatorDot extends StatelessWidget {
  const _IndicatorDot({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: active ? 8 : 6,
      height: active ? 8 : 6,
      decoration: BoxDecoration(
        color: active ? AppColors.neutral.onBase : AppColors.neutral.onMuted,
        shape: BoxShape.circle,
      ),
    );
  }
}
