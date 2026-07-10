import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_uas/theme/app_colors.dart';
import 'package:flutter_uas/theme/app_typography.dart';
import 'package:flutter_uas/data/dummy_data.dart'; 
import 'package:flutter_uas/models/ticket_model.dart';
import 'e_ticket_detail_page.dart'; 

class TicketHistoryPage extends StatefulWidget {
  const TicketHistoryPage({super.key});

  @override
  State<TicketHistoryPage> createState() => _TicketHistoryPageState();
}

class _TicketHistoryPageState extends State<TicketHistoryPage> {
  bool isAktifTab = true;

  @override
  Widget build(BuildContext context) {
    // Ambil data langsung dari list global (seperti solusi sebelumnya)
    final activeTickets = listTiketSaya.where((t) => t.isActive).toList();
    final historyTickets = listTiketSaya.where((t) => !t.isActive).toList();
    final displayTickets = isAktifTab ? activeTickets : historyTickets;

    return Scaffold(
      backgroundColor: AppColors.neutral.base,
      extendBody: true, // PENTING: Agar body berada di bawah navbar (untuk efek glass blur)
      appBar: AppBar(
        backgroundColor: AppColors.neutral.base,
        elevation: 0,
        title: Text(
          "Riwayat Tiket",
          style: AppTypography.titleMd.copyWith(color: AppColors.brand.primarySoft),
        ),
        // Menghilangkan tombol back, karena sekarang ini adalah menu utama dari Navbar
        automaticallyImplyLeading: false, 
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildTabButton("Aktif", isAktifTab, () => setState(() => isAktifTab = true)),
                  const SizedBox(width: 12),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                isAktifTab ? "Tiket Aktif" : "Riwayat Terakhir",
                style: AppTypography.titleMd.copyWith(color: AppColors.brand.primarySoft),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  // Menambahkan padding bottom agar item tidak tertutup navbar
                  padding: const EdgeInsets.only(bottom: 100), 
                  itemCount: displayTickets.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return _buildTicketCard(displayTickets[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // MENGGUNAKAN BOTTOM NAV BAR
      bottomNavigationBar: const _BottomNavBar(),
    );
  }

  Widget _buildTabButton(String title, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.brand.primary : AppColors.neutral.elevated,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: AppTypography.labelLg.copyWith(
            color: isActive ? Colors.white : AppColors.neutral.onMuted,
          ),
        ),
      ),
    );
  }

  Widget _buildTicketCard(Ticket ticket) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.neutral.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glass.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              ticket.movie.imageUrl,
              width: 80,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        ticket.movie.title,
                        style: AppTypography.titleMd.copyWith(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: ticket.isActive 
                            ? AppColors.brand.primary.withValues(alpha: 0.2)
                            : AppColors.neutral.elevated,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        ticket.isActive ? "BERHASIL" : "SELESAI",
                        style: AppTypography.labelSm.copyWith(
                          color: ticket.isActive ? AppColors.brand.primary : AppColors.neutral.onMuted,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  ticket.cinemaName,
                  style: AppTypography.bodyMd.copyWith(color: AppColors.brand.primarySoft),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("TANGGAL", style: AppTypography.labelSm.copyWith(color: AppColors.neutral.onMuted)),
                          Text(ticket.date, style: AppTypography.bodyMd.copyWith(color: Colors.white)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("JAM", style: AppTypography.labelSm.copyWith(color: AppColors.neutral.onMuted)),
                          Text(ticket.time, style: AppTypography.bodyMd.copyWith(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (ticket.isActive)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brand.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ETicketDetailPage(ticket: ticket),
                          ),
                        );
                      },
                      icon: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 18),
                      label: Text("E-Ticket", style: AppTypography.labelLg.copyWith(color: Colors.white)),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// =====================================================
/// Bottom Navigation Bar (Disalin dari homepage.dart)
/// =====================================================
class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.neutral.elevated.withValues(alpha: 0.9),
            border: Border(top: BorderSide(color: AppColors.glass.highlight)),
          ),
          child: SafeArea(
            top: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavBarItem(icon: Icons.home, label: 'Beranda', route: '/homepage'),
                _NavBarItem(icon: Icons.movie_filter_outlined, label: 'Movies', route: '/movies'),
                _NavBarItem(icon: Icons.theaters_outlined, label: 'Cinemas', route: '/cinemas'),
                // DI SINI KITA UBAH active MENJADI true
                _NavBarItem(icon: Icons.person_outline, label: 'Profil', active: true, route: '/ticket-history'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final String route;

  const _NavBarItem({
    required this.icon,
    required this.label,
    this.active = false,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final color = active
        ? AppColors.brand.primarySoft
        : AppColors.neutral.onMuted.withValues(alpha: 0.6);

    return InkWell(
      onTap: () {
        if (!active && route.isNotEmpty) {
          Navigator.pushReplacementNamed(context, route);
        }
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(label, style: AppTypography.labelSm.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}