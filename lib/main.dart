import 'package:flutter/material.dart';
import 'package:flutter_uas/data/dummy_data.dart';
import 'package:flutter_uas/screens/cinema_detail_page.dart';
import 'package:flutter_uas/screens/movie_details_page.dart';

import 'screens/login_page.dart';
import 'screens/homepage.dart';
import 'screens/onboarding.dart';
import 'theme/app_colors.dart';
import 'theme/app_typography.dart';

void main() {
  initDummyData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter UAS',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.neutral.base,
        colorScheme: ColorScheme.dark(
          surface: AppColors.neutral.base,
          primary: AppColors.brand.primary,
          secondary: AppColors.brand.secondary,
          tertiary: AppColors.brand.tertiary,
          error: AppColors.semantic.error,
          onSurface: AppColors.neutral.onBase,
        ),
        textTheme: AppTypography.textTheme,
      ),
      initialRoute: "/homepage",

      routes: {
        "/onboard": (context) => OnboardingPage(),
        "/detail-page": (context) => MovieDetailsPage(),
        "/cinema-page": (context) => CinemaDetailPage(),
        "/homepage": (context) => BerandaPage(),
        "/login": (context) => LoginPage(),
      },
    );
  }
}
