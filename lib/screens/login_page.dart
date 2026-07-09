import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral.base,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.neutral.onBase,
                  size: 20,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.neutral.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/png/cinepro.png',
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Welcome Back',
                      style: AppTypography.headlineLg.copyWith(
                        color: AppColors.neutral.onBase,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Welcome back! Ready to pick\nyour next movie night?',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyMd.copyWith(
                        color: AppColors.neutral.onMuted,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 34),
              Text(
                'Email',
                style: AppTypography.bodyMd.copyWith(
                  color: AppColors.neutral.onBase,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              _InputField(
                hintText: 'Your@mail.com',
                obscureText: false,
              ),
              const SizedBox(height: 16),
              Text(
                'Password',
                style: AppTypography.bodyMd.copyWith(
                  color: AppColors.neutral.onBase,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              _InputField(
                hintText: 'Password',
                obscureText: _obscurePassword,
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.neutral.onMuted,
                    size: 19,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forget Password ?',
                  style: AppTypography.labelLg.copyWith(
                    color: AppColors.brand.tertiary,
                    letterSpacing: 0,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brand.primary,
                    foregroundColor: AppColors.brand.onPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'LOGIN',
                    style: AppTypography.labelLg.copyWith(
                      color: AppColors.brand.onPrimary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Dont have account yet?',
                      style: AppTypography.bodyMd.copyWith(
                        color: AppColors.neutral.onMuted,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'REGISTER',
                        style: AppTypography.labelLg.copyWith(
                          color: AppColors.brand.primary,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.hintText,
    required this.obscureText,
    this.suffix,
  });

  final String hintText;
  final bool obscureText;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      style: AppTypography.bodyMd.copyWith(color: AppColors.neutral.onBase),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTypography.labelLg.copyWith(
          color: AppColors.neutral.onMuted,
          letterSpacing: 0,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: AppColors.neutral.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        suffixIcon: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.brand.primary, width: 1.2),
        ),
      ),
    );
  }
}
