import 'package:flutter/material.dart';
import 'package:flutter_uas/models/ticket_model.dart';
import 'package:flutter_uas/theme/app_colors.dart';
import 'package:flutter_uas/theme/app_typography.dart';

class ETicketDetailPage extends StatelessWidget {
  final Ticket ticket;

  const ETicketDetailPage({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral.base,
      appBar: AppBar(
        backgroundColor: AppColors.neutral.base,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "E-Ticket Detail",
          style: AppTypography.titleMd.copyWith(color: AppColors.brand.primarySoft),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.neutral.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // E-Ticket Card
            Container(
              decoration: BoxDecoration(
                color: AppColors.neutral.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.glass.border),
              ),
              child: Column(
                children: [
                  // Bagian Atas: Info Film
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            ticket.movie.imageUrl,
                            width: 70,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.neutral.elevated,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text("IMAX 2D", style: AppTypography.labelSm.copyWith(color: AppColors.neutral.onMuted)),
                              ),
                              const SizedBox(height: 8),
                              Text(ticket.movie.title, style: AppTypography.titleMd.copyWith(color: Colors.white)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined, size: 14, color: AppColors.neutral.onMuted),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      ticket.cinemaName,
                                      style: AppTypography.bodyMd.copyWith(color: AppColors.brand.primarySoft),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text("BOOKING CODE", style: AppTypography.labelSm.copyWith(color: AppColors.neutral.onMuted)),
                              Text(
                                ticket.bookingCode,
                                style: AppTypography.titleMd.copyWith(color: AppColors.brand.primarySoft),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(color: AppColors.glass.border, height: 1, indent: 16, endIndent: 16),

                  // Bagian Tengah: QR Code
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          // Dummy QR Code menggunakan Icon
                          child: const Icon(Icons.qr_code_2, size: 150, color: Colors.black),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "PINDAI KODE INI DI PINTU MASUK\nSTUDIO",
                          textAlign: TextAlign.center,
                          style: AppTypography.labelLg.copyWith(color: AppColors.brand.primarySoft, letterSpacing: 1.2),
                        ),
                      ],
                    ),
                  ),

                  Divider(color: AppColors.glass.border, height: 1, indent: 16, endIndent: 16),

                  // Bagian Bawah: Tanggal & Kursi
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("TANGGAL", style: AppTypography.labelSm.copyWith(color: AppColors.neutral.onMuted)),
                                Text(ticket.date, style: AppTypography.bodyLg.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("JAM", style: AppTypography.labelSm.copyWith(color: AppColors.neutral.onMuted)),
                                Text("${ticket.time} WIB", style: AppTypography.bodyLg.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("STUDIO", style: AppTypography.labelSm.copyWith(color: AppColors.neutral.onMuted)),
                                Text(ticket.studio, style: AppTypography.bodyLg.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("KURSI", style: AppTypography.labelSm.copyWith(color: AppColors.neutral.onMuted)),
                                Text(ticket.seats, style: AppTypography.bodyLg.copyWith(color: AppColors.brand.primary, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.info_outline, size: 16, color: AppColors.brand.primarySoft),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Tunjukkan kode QR ini kepada petugas di depan pintu masuk studio. Silakan datang 15 menit sebelum film dimulai.",
                                style: AppTypography.bodyMd.copyWith(color: AppColors.brand.primarySoft),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Tombol Action
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brand.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {},
                icon: const Icon(Icons.download_rounded, color: Colors.white),
                label: Text("Simpan ke Galeri", style: AppTypography.titleMd.copyWith(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.transparent),
                  backgroundColor: AppColors.neutral.elevated,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {},
                icon: const Icon(Icons.share_outlined, color: Colors.white),
                label: Text("Bagikan", style: AppTypography.titleMd.copyWith(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}