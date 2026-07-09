import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../data/dummy_data.dart';
import 'package:flutter_uas/models/movie_model.dart';
import 'package:flutter_uas/models/cinema_model.dart';

/// =====================================================
/// BerandaPage
/// =====================================================
class BerandaPage extends StatelessWidget {
  BerandaPage({super.key});

  final List<Movie> nowPlayingMovies = [
    movieAvatar,
    movieFurious,
    movieLesson,
    movieKim,
  ];
  final List<Cinema> nearbyCinemasList = [cinemaGrandCity, cinemaTownSquare];

  @override
  Widget build(BuildContext context) {
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
                _HeroSection(),
                const SizedBox(height: 40),
                _NowPlayingSection(movies: nowPlayingMovies),
                const SizedBox(height: 40),
                _NearbyCinemasSection(cinemas: nearbyCinemasList),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const _BottomNavBar(),
    );
  }
}

/// =====================================================
/// Top App Bar (logo + nav) dengan efek glass/blur
/// =====================================================
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
                // Logo aplikasi (sesuai gambar logo yang diberikan)
                Image.asset(
                  'assets/png/cinepro.png',
                  height: 28,
                  color: AppColors.brand.primary,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.movie,
                    color: AppColors.brand.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 8),
                const Spacer(),
                // Nav desktop disembunyikan di layar sempit (mobile-first)
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (MediaQuery.of(context).size.width < 768) {
                      return IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          color: AppColors.neutral.onMuted,
                        ),
                      );
                    }
                    return Row(
                      children: [
                        _NavLink(label: 'Beranda', active: true),
                        _NavLink(label: 'Movies'),
                        _NavLink(label: 'Cinemas'),
                        _NavLink(label: 'Profil'),
                      ],
                    );
                  },
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

class _NavLink extends StatelessWidget {
  final String label;
  final bool active;

  const _NavLink({required this.label, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        label,
        style: AppTypography.bodyLg.copyWith(
          color: active ? AppColors.brand.primary : AppColors.neutral.onMuted,
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

/// =====================================================
/// Hero Section (poster utama)
/// =====================================================
class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 420,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.glass.border),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuDiO9Lzx1do32SNhXEWREJH0UkWY50S6_f7uchqyrpY74fqMCjRQ_FnsDXJHzz5MCQ2ELZeJoVMwz_4GvMYX9P-XYLzOUMhn_vhsn3Pd_9ZimjvB5Vh12OtD_waC77KaagIHvojOe_pj-hC79xoZXGinXYg4J8wrUmAqWV7frlot4KhjqOhbJQtK2FJbaKl9DF4KC0GL1JyPN8DsTQ95YOoYsCleavAdzlBRxRUQ3slJNC0qi1somjoqw',
              fit: BoxFit.cover,
            ),
            // Gradient overlay agar teks tetap terbaca
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.9),
                    Colors.black.withValues(alpha: 0.0),
                  ],
                  stops: const [0.0, 0.6],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _Chip(label: 'IMAX'),
                      const SizedBox(width: 8),
                      _Chip(label: 'Sci-Fi'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Starlight Odyssey',
                    style: AppTypography.headlineLgMobile.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "A gripping tale of humanity's last hope as a crew journeys through the perilous uncharted regions of the galaxy.",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodyMd.copyWith(
                      color: AppColors.neutral.onMuted,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brand.primary,
                      foregroundColor: AppColors.brand.onPrimary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Beli Tiket',
                      style: AppTypography.bodyLg.copyWith(
                        color: AppColors.brand.onPrimary,
                        fontFamily: AppTypography.titleMd.fontFamily,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;

  const _Chip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.neutral.elevated.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.glass.border),
      ),
      child: Text(
        label,
        style: AppTypography.labelSm.copyWith(color: Colors.white),
      ),
    );
  }
}

/// =====================================================
/// Sedang Tayang (Now Playing) Section
/// =====================================================
class _NowPlayingSection extends StatelessWidget {
  final List<Movie> movies;

  const _NowPlayingSection({required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Sedang Tayang',
              style: AppTypography.titleMd.copyWith(color: Colors.white),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                children: [
                  Text(
                    'Lihat Semua',
                    style: AppTypography.labelLg.copyWith(
                      color: AppColors.brand.secondary,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: AppColors.brand.secondary,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 290,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) => _MovieCard(movie: movies[index]),
          ),
        ),
      ],
    );
  }
}

class _MovieCard extends StatelessWidget {
  final Movie movie;

  const _MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/detail-page", arguments: movie);
      },
      child: SizedBox(
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.glass.border),
                ),
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        movie
                            .imageUrl, // FIX: Mengubah dari posterAsset ke imageUrl
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: AppColors.neutral.elevated,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: AppColors.neutral.onMuted,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: AppColors.glass.border),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                size: 14,
                                color: AppColors.brand.tertiary,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                movie.rating
                                    .toString(), // FIX: Ditambahkan .toString() karena rating berupa double
                                style: AppTypography.labelSm.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.bodyLg.copyWith(
                color: Colors.white,
                fontFamily: AppTypography.titleMd.fontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              // FIX: Menggabungkan list genres dan format durasi menit agar outputnya mirip ('Action • 100m')
              '${movie.genres.join(', ')} • ${movie.durationMinutes}m',
              style: AppTypography.labelSm.copyWith(
                color: AppColors.neutral.onMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =====================================================
/// Bioskop Terdekat (Nearby Cinemas) Section
/// =====================================================
class _NearbyCinemasSection extends StatelessWidget {
  final List<Cinema> cinemas;

  const _NearbyCinemasSection({required this.cinemas});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bioskop Terdekat',
          style: AppTypography.titleMd.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 768;
            if (isWide) {
              return GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 3.4,
                children: cinemas
                    .map((cinema) => _CinemaCard(cinema: cinema))
                    .toList(),
              );
            }
            return Column(
              children: cinemas
                  .map(
                    (cinema) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _CinemaCard(cinema: cinema),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}

class _CinemaCard extends StatelessWidget {
  final Cinema cinema;

  const _CinemaCard({required this.cinema});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.neutral.surface.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.glass.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.neutral.elevated,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.glass.highlight),
            ),
            child: Icon(
              Icons.theaters,
              size: 32,
              color: AppColors.brand.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cinema.name,
                  style: AppTypography.bodyLg.copyWith(
                    color: Colors.white,
                    fontFamily: AppTypography.titleMd.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  cinema.distanceKm.toString(),
                  style: AppTypography.labelSm.copyWith(
                    color: AppColors.neutral.onMuted,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: cinema.tags.map((tag) {
                    final isImax = tag == 'IMAX';
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isImax
                            ? AppColors.brand.secondary.withValues(alpha: 0.2)
                            : AppColors.neutral.elevated,
                        borderRadius: BorderRadius.circular(4),
                        border: isImax
                            ? Border.all(
                                color: AppColors.brand.secondary.withValues(
                                  alpha: 0.3,
                                ),
                              )
                            : null,
                      ),
                      child: Text(
                        tag,
                        style: AppTypography.labelSm.copyWith(
                          color: isImax
                              ? AppColors.brand.secondary
                              : AppColors.neutral.onMuted,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: AppColors.neutral.onMuted),
        ],
      ),
    );
  }
}

/// =====================================================
/// Bottom Navigation Bar
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
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.neutral.elevated.withValues(alpha: 0.9),
            border: Border(top: BorderSide(color: AppColors.glass.highlight)),
          ),
          child: SafeArea(
            top: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavBarItem(icon: Icons.home, label: 'Beranda', active: true),
                _NavBarItem(icon: Icons.movie_filter_outlined, label: 'Movies'),
                _NavBarItem(icon: Icons.theaters_outlined, label: 'Cinemas'),
                _NavBarItem(icon: Icons.person_outline, label: 'Profil'),
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

  const _NavBarItem({
    required this.icon,
    required this.label,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = active
        ? AppColors.brand.primary
        : AppColors.neutral.onMuted.withValues(alpha: 0.6);

    return InkWell(
      onTap: () {},
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
