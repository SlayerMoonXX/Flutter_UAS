import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 1. Tambahkan FormKey untuk keperluan validasi
  final _formKey = GlobalKey<FormState>();

  // 2. Tambahkan Controller untuk menangkap data input
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  // Pastikan untuk melakukan dispose pada controller agar tidak terjadi memory leak
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 3. Buat fungsi untuk menangani proses login
  void _handleLogin() {
    // Mengecek apakah semua input di dalam form sudah valid
    if (_formKey.currentState!.validate()) {
      // Jika valid, ambil datanya (Opsional: berguna jika ingin dikirim ke API)
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      // Pindah ke halaman HomePage. 
      // Menggunakan pushReplacementNamed agar user tidak bisa kembali ke halaman login 
      // menggunakan tombol 'back' perangkat mereka setelah berhasil login.
      // (Pastikan kamu sudah mendefinisikan rute '/home' di main.dart)
      Navigator.pushReplacementNamed(context, '/homepage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral.base,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
          // 4. Bungkus Column dengan Widget Form
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

                // ---------- Input Email ----------
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
                  // Tambahkan validasi email
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Format email tidak valid';
                    }
                    return null; // Null menandakan tidak ada error
                  },
                ),
                const SizedBox(height: 16),

                // ---------- Input Password ----------
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
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.neutral.onMuted,
                      size: 19,
                    ),
                  ),
                  // Tambahkan validasi password
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    return null;
                  },
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

                // ---------- Tombol Login ----------
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _handleLogin, // Sambungkan ke fungsi login
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
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
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
      ),
    );
  }
}

// 5. Ubah StatelessWidget ini
class _InputField extends StatelessWidget {
  const _InputField({
    required this.hintText,
    required this.obscureText,
    this.suffix,
    this.controller, // Tambahan parameter
    this.validator,  // Tambahan parameter
  });

  final String hintText;
  final bool obscureText;
  final Widget? suffix;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    // Ubah dari TextField menjadi TextFormField agar bisa menampung `validator`
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
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
        // Tambahkan Error Border agar UI terlihat rapi saat validasi gagal
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