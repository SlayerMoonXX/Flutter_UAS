import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../data/dummy_data.dart';
import '../models/cinema_model.dart';

class CinemasPage extends StatelessWidget {
  const CinemasPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Collect all cinemas from dummy data
    final List<Cinema> allCinemas = [
      cinemaGI,
      cinemaPS,
      cinemaPIM,
      cinemaGrandCity,
      cinemaTownSquare,
    ];

    return Scaffold(
      backgroundColor: AppColors.neutral.base,
      extendBody: true,
      appBar: _TopAppBar(),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 120),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _SearchBar(),
                const SizedBox(height: 16),
                _Filters(),
                const SizedBox(height: 24),
                ...allCinemas.map((cinema) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _CinemaCardLg(cinema: cinema),
                    )),
                const SizedBox(height: 8),
                _ExclusiveOfferBanner(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const _BottomNavBar(activeTab: 'Cinemas'),
    );
  }
}

class _TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          color: AppColors.neutral.surface.withValues(alpha: 0.8),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
            bottom: false,
            child: Row(
              children: [
                Image.asset(
                  'assets/png/cinepro.png',
                  height: 24,
                  color: AppColors.brand.primarySoft, // Using a softer color as in design or just white/primary
                  errorBuilder: (context, error, stackTrace) => Row(
                    children: [
                      Icon(Icons.movie_creation_outlined, color: AppColors.brand.primarySoft, size: 24),
                      const SizedBox(width: 8),
                      Text('CinePremium', style: AppTypography.titleMd.copyWith(color: AppColors.brand.primarySoft)),
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_none,
                    color: AppColors.neutral.onBase,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral.elevated,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        style: AppTypography.bodyMd.copyWith(color: AppColors.neutral.onBase),
        decoration: InputDecoration(
          hintText: 'Cari bioskop...',
          hintStyle: AppTypography.bodyMd.copyWith(color: AppColors.neutral.onMuted),
          prefixIcon: Icon(Icons.search, color: AppColors.neutral.onMuted, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}

class _Filters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.neutral.elevated,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on_outlined, color: AppColors.neutral.onMuted, size: 16),
                const SizedBox(width: 6),
                Text('Jakarta Pusat', style: AppTypography.bodyMd.copyWith(color: AppColors.neutral.onMuted)),
                const SizedBox(width: 4),
                Icon(Icons.keyboard_arrow_down, color: AppColors.neutral.onMuted, size: 16),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _FilterChip(label: 'All', isActive: true),
          const SizedBox(width: 8),
          _FilterChip(label: 'IMAX', isActive: false),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;

  const _FilterChip({required this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? AppColors.brand.primary : AppColors.neutral.elevated,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: AppTypography.bodyMd.copyWith(
          color: isActive ? AppColors.brand.onPrimary : AppColors.neutral.onMuted,
        ),
      ),
    );
  }
}

class _CinemaCardLg extends StatelessWidget {
  final Cinema cinema;

  const _CinemaCardLg({required this.cinema});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.neutral.surface,
        borderRadius: BorderRadius.circular(12),
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
                  style: AppTypography.titleMd.copyWith(color: AppColors.neutral.onBase),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (cinema.tags.contains('PREMIERE'))
                Icon(Icons.stars, color: AppColors.brand.primary, size: 20)
              else if (cinema.tags.contains('IMAX'))
                Icon(Icons.verified, color: AppColors.brand.secondary, size: 20)
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '${cinema.distanceKm} km • ${cinema.address.split(',').first}, ${cinema.cityArea}',
            style: AppTypography.bodyMd.copyWith(color: AppColors.neutral.onMuted),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: cinema.tags.map((tag) {
              final isImax = tag == 'IMAX';
              final isPremiere = tag == 'PREMIERE';
              Color bgColor = AppColors.neutral.elevated;
              Color textColor = AppColors.neutral.onMuted;
              
              if (isImax) {
                bgColor = AppColors.brand.secondary.withValues(alpha: 0.2);
                textColor = AppColors.brand.secondary;
              } else if (isPremiere) {
                bgColor = AppColors.brand.primary.withValues(alpha: 0.2);
                textColor = AppColors.brand.primary;
              }
              
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(tag, style: AppTypography.labelSm.copyWith(color: textColor)),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.access_time, color: AppColors.neutral.onMuted, size: 16),
                  const SizedBox(width: 6),
                  Text('Buka: 10:00 - 22:00', style: AppTypography.labelSm.copyWith(color: AppColors.neutral.onMuted)),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/cinema-page", arguments: cinema);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brand.primary,
                  foregroundColor: AppColors.brand.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  minimumSize: const Size(100, 36),
                ),
                child: Text('Lihat Jadwal', style: AppTypography.labelLg.copyWith(color: AppColors.brand.onPrimary)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExclusiveOfferBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glass.border),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              'https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withValues(alpha: 0.9),
                  Colors.black.withValues(alpha: 0.2),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EXCLUSIVE OFFER',
                  style: AppTypography.labelLg.copyWith(
                    color: AppColors.brand.primarySoft,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Nikmati Pengalaman\nIMAX Dengan Diskon\n20%',
                  style: AppTypography.titleMd.copyWith(color: Colors.white, fontSize: 22, height: 1.2),
                ),
                const SizedBox(height: 12),
                Text(
                  'Berlaku untuk seluruh studio IMAX di Jakarta\nselama periode akhir pekan ini.',
                  style: AppTypography.labelSm.copyWith(color: AppColors.neutral.onMuted),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text('Klaim Promo', style: AppTypography.labelLg.copyWith(color: Colors.black)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final String activeTab;
  const _BottomNavBar({required this.activeTab});

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
                _NavBarItem(icon: Icons.home, label: 'Beranda', active: activeTab == 'Beranda', route: '/homepage'),
                _NavBarItem(icon: Icons.movie_filter_outlined, label: 'Movies', active: activeTab == 'Movies', route: '/movies'),
                _NavBarItem(icon: Icons.theaters_outlined, label: 'Cinemas', active: activeTab == 'Cinemas', route: '/cinemas'),
                _NavBarItem(icon: Icons.person_outline, label: 'Profil', active: activeTab == 'Profil', route: ''),
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
        ? AppColors.brand.primarySoft // Using primarySoft as it seems slightly softer in the design than pure red
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
