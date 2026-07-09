import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const NeutralColors neutral = NeutralColors._();
  static const BrandColors brand = BrandColors._();
  static const SemanticColors semantic = SemanticColors._();
  static const GlassColors glass = GlassColors._();
}

class NeutralColors {
  const NeutralColors._();

  final Color base = const Color(0xFF0F0F0F);
  final Color surface = const Color(0xFF1A1A1A);
  final Color elevated = const Color(0xFF2A2A2A);
  final Color outline = const Color(0xFF5A5A5A);
  final Color white = const Color(0xFFF5F5F5);
  final Color onBase = const Color(0xFFFFFFFF);
  final Color onMuted = const Color(0xFFB3B3B3);
}

class BrandColors {
  const BrandColors._();

  final Color primary = const Color(0xFFE50914);
  final Color secondary = const Color(0xFF007AFF);
  final Color tertiary = const Color(0xFFFFB800);
  final Color primarySoft = const Color(0xFFFFD1D4);
  final Color secondarySoft = const Color(0xFFD6E8FF);
  final Color tertiarySoft = const Color(0xFFFFE7B3);
  final Color onPrimary = const Color(0xFFFFFFFF);
  final Color onSecondary = const Color(0xFFFFFFFF);
  final Color onTertiary = const Color(0xFF1A1200);
}

class SemanticColors {
  const SemanticColors._();

  final Color error = const Color(0xFFE50914);
  final Color onError = const Color(0xFFFFFFFF);
  final Color warning = const Color(0xFFFFB800);
  final Color success = const Color(0xFF007AFF);
}

class GlassColors {
  const GlassColors._();

  final Color border = const Color(0x1AFFFFFF);
  final Color highlight = const Color(0x14FFFFFF);
}
