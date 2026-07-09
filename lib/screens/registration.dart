import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// CinePro - Halaman Registrasi
/// Desain disesuaikan agar konsisten dengan LoginPage
/// (menggunakan AppColors & AppTypography, layout serupa).
/// Logika penting (controller, validator, toggle password, submit)
/// TIDAK diubah.

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrasi berhasil diproses!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral.base,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
          child: Form(
            key: _formKey,
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
                      // ---------- LOGO APP ----------
                      // Logo baru (siluet putih transparan) diwarnai ulang
                      // memakai ColorFiltered agar otomatis mengikuti
                      // warna brand di tema (AppColors.brand.primary).
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          AppColors.brand.primary,
                          BlendMode.srcIn,
                        ),
                        child: Image.asset(
                          'assets/png/cinepro.png',
                          height: 40,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'Create Account',
                        style: AppTypography.headlineLg.copyWith(
                          color: AppColors.neutral.onBase,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Buat akun untuk pengalaman\nsinematik tanpa batas.',
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

                // ---------- Nama Lengkap ----------
                Text(
                  'Nama Lengkap',
                  style: AppTypography.bodyMd.copyWith(
                    color: AppColors.neutral.onBase,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                _InputField(
                  controller: _fullNameController,
                  hintText: 'Masukkan nama lengkap',
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama lengkap wajib diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // ---------- Email ----------
                Text(
                  'Email',
                  style: AppTypography.bodyMd.copyWith(
                    color: AppColors.neutral.onBase,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                _InputField(
                  controller: _emailController,
                  hintText: 'Your@mail.com',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email wajib diisi';
                    }
                    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Format email tidak valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // ---------- Kata Sandi ----------
                Text(
                  'Password',
                  style: AppTypography.bodyMd.copyWith(
                    color: AppColors.neutral.onBase,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                _InputField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: _obscurePassword,
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.neutral.onMuted,
                      size: 19,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kata sandi wajib diisi';
                    }
                    if (value.length < 8) {
                      return 'Kata sandi minimal 8 karakter';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // ---------- Konfirmasi Kata Sandi ----------
                Text(
                  'Confirm Password',
                  style: AppTypography.bodyMd.copyWith(
                    color: AppColors.neutral.onBase,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                _InputField(
                  controller: _confirmPasswordController,
                  hintText: 'Ulangi password',
                  obscureText: _obscureConfirmPassword,
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.neutral.onMuted,
                      size: 19,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Konfirmasi kata sandi wajib diisi';
                    }
                    if (value != _passwordController.text) {
                      return 'Kata sandi tidak cocok';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 28),

                // ---------- Submit Button ----------
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brand.primary,
                      foregroundColor: AppColors.brand.onPrimary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'REGISTER',
                      style: AppTypography.labelLg.copyWith(
                        color: AppColors.brand.onPrimary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                // ---------- Login Link ----------
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Sudah punya akun?',
                        style: AppTypography.bodyMd.copyWith(
                          color: AppColors.neutral.onMuted,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'LOGIN',
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
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.hintText,
    required this.obscureText,
    this.controller,
    this.suffix,
    this.keyboardType,
    this.validator,
  });

  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.2),
        ),
      ),
    );
  }
}