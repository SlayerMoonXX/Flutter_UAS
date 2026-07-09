import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static final TextStyle displayLg = GoogleFonts.sora(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 48 / 40,
    letterSpacing: -0.8,
  );

  static final TextStyle headlineLg = GoogleFonts.sora(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 40 / 32,
  );

  static final TextStyle headlineLgMobile = GoogleFonts.sora(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 32 / 24,
  );

  static final TextStyle titleMd = GoogleFonts.sora(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 28 / 20,
  );

  static final TextStyle bodyLg = GoogleFonts.hankenGrotesk(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
  );

  static final TextStyle bodyMd = GoogleFonts.hankenGrotesk(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
  );

  static final TextStyle labelLg = GoogleFonts.hankenGrotesk(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 16 / 12,
    letterSpacing: 0.6,
  );

  static final TextStyle labelSm = GoogleFonts.hankenGrotesk(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 14 / 10,
    letterSpacing: 0.5,
  );

  static TextStyle uppercaseLabel(TextStyle style) {
    return style.copyWith(letterSpacing: 0.8);
  }

  static TextTheme get textTheme => TextTheme(
    displayLarge: displayLg,
    headlineLarge: headlineLg,
    headlineMedium: headlineLgMobile,
    titleLarge: titleMd,
    bodyLarge: bodyLg,
    bodyMedium: bodyMd,
    labelLarge: labelLg,
    labelSmall: labelSm,
  );
}
