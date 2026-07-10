import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../data/dummy_data.dart'; // Sesuaikan path ini
import 'package:flutter_uas/models/movie_model.dart'; // Sesuaikan path ini

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  // Dummy data filter
  final List<String> categories = [
    'All',
    'Action',
    'Sci-Fi',
    'Drama',
    'Horror',
  ];
  String selectedCategory = 'All';

  // Menggunakan dummy data dari data sebelumnya
  final List<Movie> nowPlayingMovies = [
    movieAvatar,
    movieFurious,
    movieLesson,
    movieKim,
    // Tambahkan dummy data lain jika ada
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral.base,
      extendBody: true,
      appBar: _buildCustomAppBar(),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 120),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                _buildComingSoonSection(),
                const SizedBox(height: 32),
                _buildNowPlayingSection(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const _BottomNavBarMovies(),
    );
  }

  /// App Bar Kustom dengan Logo Text dan Icon Notifikasi
  PreferredSizeWidget _buildCustomAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(64),
      child: Container(
        color: AppColors.neutral.base,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          bottom: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget Section Coming Soon (Sneak Peek)
  Widget _buildComingSoonSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PREMIUM SNEAK PEEK',
          style: AppTypography.labelSm.copyWith(
            color: AppColors.brand.primary,
            letterSpacing: 1.2,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Coming Soon',
              style: AppTypography.titleMd.copyWith(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Card Coming Soon
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.glass.border),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/jpg/neon_shadows.jpg', // Ganti dengan aset gambar Coming Soon Anda
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(color: AppColors.neutral.elevated),
                ),
                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.9),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.brand.primary,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'EXCLUSIVE',
                              style: AppTypography.labelSm.copyWith(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'IMAX',
                              style: AppTypography.labelSm.copyWith(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Chronicles of Kepler',
                        style: AppTypography.titleMd.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Rilis 24 Desember • Sci-Fi Thriller',
                        style: AppTypography.labelSm.copyWith(
                          color: AppColors.neutral.onMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Widget Section Sedang Tayang (Grid view 2 kolom)
  Widget _buildNowPlayingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sedang Tayang',
          style: AppTypography.titleMd.copyWith(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio:
                0.55, // Disesuaikan agar muat untuk teks dan gambar
            crossAxisSpacing: 16,
            mainAxisSpacing: 24,
          ),
          itemCount: nowPlayingMovies.length,
          itemBuilder: (context, index) {
            final movie = nowPlayingMovies[index];
            return _buildGridMovieCard(movie, context);
          },
        ),
      ],
    );
  }

  /// Card untuk setiap film di Grid
  Widget _buildGridMovieCard(Movie movie, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/detail-page", arguments: movie);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    movie.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(color: AppColors.neutral.elevated),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            size: 12,
                            color: AppColors.brand.tertiary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            movie.rating.toString(),
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
          const SizedBox(height: 12),
          Text(
            movie.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.bodyLg.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${movie.genres.join(', ')} • ${movie.durationMinutes}m',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.labelSm.copyWith(
              color: AppColors.neutral.onMuted,
            ),
          ),
        ],
      ),
    );
  }
}

/// =====================================================
/// Bottom Navigation Bar (Khusus State "Movies" Aktif)
/// =====================================================
class _BottomNavBarMovies extends StatelessWidget {
  const _BottomNavBarMovies();

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
                  icon: Icons.home_outlined,
                  label: 'Beranda',
                  active: false,
                  route: '/homepage',
                ),
                // "Movies" diset active = true
                _NavBarItem(
                  icon: Icons.movie_filter,
                  label: 'Movies',
                  active: true,
                  route: '/movies',
                ),
                _NavBarItem(
                  icon: Icons.theaters_outlined,
                  label: 'Cinemas',
                  active: false,
                  route: '/cinemas',
                ),
                _NavBarItem(
                  icon: Icons.person_outline,
                  label: 'Profil',
                  active: false,
                  route: 'ticket-history',
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
          // Navigasi ke rute lain tanpa animasi default bawaan agar terlihat seperti ganti tab
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
