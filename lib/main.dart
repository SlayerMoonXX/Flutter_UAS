import 'package:flutter/material.dart';
import 'package:flutter_uas/data/dummy_data.dart';
import 'package:flutter_uas/screens/cinema_detail_page.dart';
import 'package:flutter_uas/screens/movie_details_page.dart';

import 'screens/ticket_history_page.dart';
import 'data/dummy_data.dart';
import 'screens/cinemas_page.dart';
import 'screens/cinema_detail_page.dart';
import 'screens/registration.dart';
import 'screens/login_page.dart';
import 'screens/homepage.dart';
import 'screens/onboarding.dart';
import 'screens/movies_page.dart';
<<<<<<< HEAD
=======
import 'screens/cinemas_page.dart';
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a
import 'theme/app_colors.dart';
import 'theme/app_typography.dart';

void main() {
<<<<<<< HEAD
  initDummyData(); // Inisialisasi data dummy sebelum menjalankan aplikasi
=======
  initDummyData();
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a
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
<<<<<<< HEAD
        "/register": (context) => RegistrationPage(),
        "/cinema-page": (context) => CinemaDetailPage(),
        "/movies": (context) => MoviesPage(),
        "/cinemas": (context) => CinemasPage(),
        '/ticket-history': (context) => const TicketHistoryPage(),
=======
        "/movies": (context) => const MoviesPage(),
        "/cinemas": (context) => const CinemasPage(),
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a
      },
    );
  }
}
