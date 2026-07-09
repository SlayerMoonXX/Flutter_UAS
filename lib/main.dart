import 'package:flutter/material.dart';
import 'package:flutter_uas/screens/movie_details_page.dart';

import 'screens/registration.dart';
import 'screens/login_page.dart';
import 'screens/homepage.dart';
import 'screens/onboarding.dart';
import 'theme/app_colors.dart';
import 'theme/app_typography.dart';

void main() {
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
      initialRoute: "/onboard",

      routes: {
        "/onboard": (context) => OnboardingPage(),
        "/detail-page": (context) => MovieDetailsPage(),
        "/homepage": (context) => BerandaPage(),
        "/login": (context) => LoginPage(),
        "/register": (context) => RegistrationPage(),
      },
    );
  }
}
