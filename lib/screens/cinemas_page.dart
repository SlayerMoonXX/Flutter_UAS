import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../models/cinema_model.dart';
import '../data/dummy_data.dart';

class CinemasPage extends StatelessWidget {
  const CinemasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral.base,
      extendBody: true,
      appBar: _TopAppBar(),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 120, top: 16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cinemas',
                  style: AppTypography.headlineLg.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 24),
                // Daftar Bioskop (menggunakan data Cinema asli dari dummy_data.dart
                // agar tombol "Lihat Jadwal" bisa membawa objek Cinema ke halaman detail)
                _CinemaListCard(
                  cinema: cinemaGI,
                  distance: '${cinemaGI.distanceKm} km • ${cinemaGI.cityArea}',
                  openTime: '10:00 - 22:00',
                  iconSuffix: Icons.stars,
                  iconColor: AppColors.brand.primary,
                ),
                _CinemaListCard(
                  cinema: cinemaPS,
                  distance: '${cinemaPS.distanceKm} km • ${cinemaPS.cityArea}',
                  openTime: '11:00 - 21:00',
                ),
                _CinemaListCard(
                  cinema: cinemaPIM,
                  distance:
                      '${cinemaPIM.distanceKm} km • ${cinemaPIM.cityArea}',
                  openTime: '10:30 - 22:00',
                ),
                _CinemaListCard(
                  cinema: cinemaGrandCity,
                  distance:
                      '${cinemaGrandCity.distanceKm} km • ${cinemaGrandCity.cityArea}',
                  openTime: '11:00 - 23:00',
                  iconSuffix: Icons.verified,
                  iconColor: AppColors.brand.secondary,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const _BottomNavBar(activeIndex: 2),
    );
  }
}

/// App Bar Halaman Cinemas
class _TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          // Logo aplikasi (sesuai gambar logo yang diberikan)
          Image.asset(
            'assets/png/cinepro.png',
            height: 28,
            color: AppColors.brand.primary,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.movie, color: AppColors.brand.primary, size: 28),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

/// Card Bioskop List
class _CinemaListCard extends StatelessWidget {
  final Cinema cinema;
  final String distance;
  final String openTime;
  final IconData? iconSuffix;
  final Color? iconColor;

  const _CinemaListCard({
    required this.cinema,
    required this.distance,
    required this.openTime,
    this.iconSuffix,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.neutral.surface.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glass.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  cinema.name,
                  style: AppTypography.titleMd.copyWith(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (iconSuffix != null) ...[
                const SizedBox(width: 8),
                Icon(iconSuffix, color: iconColor, size: 20),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Text(
            distance,
            style: AppTypography.labelSm.copyWith(
              color: AppColors.neutral.onMuted,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: cinema.tags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.neutral.elevated.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.glass.highlight),
                ),
                child: Text(
                  tag,
                  style: AppTypography.labelSm.copyWith(
                    color: AppColors.neutral.onMuted,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 14,
                    color: AppColors.neutral.onMuted,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Buka: $openTime',
                    style: AppTypography.labelSm.copyWith(
                      color: AppColors.neutral.onMuted,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman detail bioskop (sesuai desain: foto besar,
                  // fasilitas cinema, peta lokasi, dan film yang sedang tayang)
                  Navigator.pushNamed(
                    context,
                    '/cinema-page',
                    arguments: cinema,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brand.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  minimumSize: Size.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Lihat Jadwal', style: AppTypography.labelSm),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Reusable Bottom Navigation (dimodifikasi agar menerima `activeIndex`)
class _BottomNavBar extends StatelessWidget {
  final int activeIndex;
  const _BottomNavBar({required this.activeIndex});

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
                _NavBarItem(
                  icon: Icons.home,
                  label: 'Beranda',
                  route: '/homepage',
                ),
                _NavBarItem(
                  icon: Icons.movie_filter_outlined,
                  label: 'Movies',
                  route: '/movies',
                ),
                _NavBarItem(
                  icon: Icons.theaters_outlined,
                  label: 'Cinemas',
                  active: true,
                  route: '/cinemas',
                ),
                _NavBarItem(
                  icon: Icons.person_outline,
                  label: 'Profil',
                  route: '/ticket-history',
                ),
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
