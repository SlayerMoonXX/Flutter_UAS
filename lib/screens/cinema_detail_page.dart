import 'package:flutter/material.dart';
import 'package:flutter_uas/models/cinema_model.dart';
import 'package:flutter_uas/theme/app_colors.dart';
import 'package:flutter_uas/theme/app_typography.dart';

class CinemaDetailPage extends StatefulWidget {
  const CinemaDetailPage({super.key});

  @override
  State<CinemaDetailPage> createState() => _CinemaDetailState();
}

class _CinemaDetailState extends State<CinemaDetailPage> {
  @override
  Widget build(BuildContext context) {
    final cinema = ModalRoute.of(context)!.settings.arguments as Cinema;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/jpg/cgv-poster.jpg",
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                Positioned(
                  bottom: 20,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: [
                          // REVISI: Ganti string statis di bawah menggunakan data dari activeMovie jika perlu
                        ],
                      ),
                      const SizedBox(height: 16),
                      //Judul dan desc
                      Text(cinema.name, style: AppTypography.headlineLgMobile),
                      const SizedBox(height: 16),
                      Text(
                        cinema.address,
                        style: AppTypography.bodyMd.copyWith(
                          color: AppColors.brand.primarySoft,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            //Setelah image
          ],
        ),
      ),
    );
  }
}
