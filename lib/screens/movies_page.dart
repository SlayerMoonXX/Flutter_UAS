import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
<<<<<<< HEAD
import '../data/dummy_data.dart'; // Sesuaikan path ini
import 'package:flutter_uas/models/movie_model.dart'; // Sesuaikan path ini

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  // Dummy data filter
  final List<String> categories = ['All', 'Action', 'Sci-Fi', 'Drama', 'Horror'];
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
=======
import '../data/dummy_data.dart';
import '../models/movie_model.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Collect all movies for "Sedang Tayang"
    final List<Movie> nowPlaying = [
      movieDune,
      movieOppenheimer,
      movieSpiderVerse,
      movieJohnWick,
      movieAvatar,
      movieFurious,
    ];

    return Scaffold(
      backgroundColor: AppColors.neutral.base,
      extendBody: true,
      appBar: _TopAppBar(),
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a
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
<<<<<<< HEAD
                _buildSearchBar(),
                const SizedBox(height: 24),
                _buildComingSoonSection(),
                const SizedBox(height: 32),
                _buildNowPlayingSection(),
=======
                _SearchBar(),
                const SizedBox(height: 16),
                _GenreFilters(),
                const SizedBox(height: 24),
                _ComingSoonSection(),
                const SizedBox(height: 32),
                _NowPlayingSection(movies: nowPlaying),
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a
              ],
            ),
          ),
        ),
      ),
<<<<<<< HEAD
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
                children: [ // Logo aplikasi (sesuai gambar logo yang diberikan)
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
=======
      bottomNavigationBar: const _BottomNavBar(activeTab: 'Movies'),
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
                  color: AppColors.brand.primarySoft,
                  errorBuilder: (context, error, stackTrace) => Row(
                    children: [
                      Icon(
                        Icons.movie_creation_outlined,
                        color: AppColors.brand.primarySoft,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'CinePremium',
                        style: AppTypography.titleMd.copyWith(
                          color: AppColors.brand.primarySoft,
                        ),
                      ),
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
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a
          ),
        ),
      ),
    );
  }

<<<<<<< HEAD
  /// Widget Search Bar
  Widget _buildSearchBar() {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Cari film, aktor, atau sutradara...',
        hintStyle: AppTypography.bodyMd.copyWith(color: AppColors.neutral.onMuted),
        prefixIcon: Icon(Icons.search, color: AppColors.neutral.onMuted),
        filled: true,
        fillColor: AppColors.neutral.elevated,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
=======
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
          hintText: 'Cari film, aktor, atau sutradara...',
          hintStyle: AppTypography.bodyMd.copyWith(
            color: AppColors.neutral.onMuted,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.neutral.onMuted,
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a
        ),
      ),
    );
  }
<<<<<<< HEAD

  /// Widget Section Coming Soon (Sneak Peek)
  Widget _buildComingSoonSection() {
=======
}

class _GenreFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterChip(label: 'All', isActive: true),
          const SizedBox(width: 8),
          _FilterChip(label: 'Action', isActive: false),
          const SizedBox(width: 8),
          _FilterChip(label: 'Sci-Fi', isActive: false),
          const SizedBox(width: 8),
          _FilterChip(label: 'Drama', isActive: false),
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
          color: isActive
              ? AppColors.brand.onPrimary
              : AppColors.neutral.onMuted,
        ),
      ),
    );
  }
}

class _ComingSoonSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PREMIUM SNEAK PEEK',
          style: AppTypography.labelSm.copyWith(
            color: AppColors.brand.primary,
<<<<<<< HEAD
            letterSpacing: 1.2,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
=======
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Coming Soon',
<<<<<<< HEAD
              style: AppTypography.titleMd.copyWith(color: Colors.white, fontSize: 22),
=======
              style: AppTypography.titleMd.copyWith(color: Colors.white),
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a
            ),
            Row(
              children: [
                Text(
                  'Lihat Semua',
<<<<<<< HEAD
                  style: AppTypography.labelLg.copyWith(color: AppColors.brand.primary),
                ),
                Icon(Icons.arrow_forward, size: 16, color: AppColors.brand.primary),
              ],
            )
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
                  errorBuilder: (_, __, ___) => Container(color: AppColors.neutral.elevated),
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
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.brand.primary,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'EXCLUSIVE',
                              style: AppTypography.labelSm.copyWith(color: Colors.white, fontSize: 8),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'IMAX',
                              style: AppTypography.labelSm.copyWith(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Chronicles of Kepler',
                        style: AppTypography.titleMd.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Rilis 24 Desember • Sci-Fi Thriller',
                        style: AppTypography.labelSm.copyWith(color: AppColors.neutral.onMuted),
                      ),
                    ],
                  ),
                )
              ],
            ),
=======
                  style: AppTypography.labelLg.copyWith(
                    color: AppColors.brand.primary,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: AppColors.brand.primary,
                  size: 16,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _ComingSoonCard(
                title: 'Chronicles of Kepler',
                releaseDate: 'Rilis 24 Desember',
                genre: 'Sci-Fi Thriller',
                imageUrl:
                    'https://images.unsplash.com/photo-1614729939124-032f0b56c9ce?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
                isExclusive: true,
                isImax: true,
              ),
              const SizedBox(width: 16),
              _ComingSoonCard(
                title: 'Dune: Part Two', // Reusing dummy movie data for visual
                releaseDate: 'Rilis 1 Januari',
                genre: 'Sci-Fi Adventure',
                imageUrl: movieDune.imageUrl,
                isExclusive: false,
                isImax: true,
              ),
            ],
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a
          ),
        ),
      ],
    );
  }
<<<<<<< HEAD

  /// Widget Section Sedang Tayang (Grid view 2 kolom)
  Widget _buildNowPlayingSection() {
=======
}

class _ComingSoonCard extends StatelessWidget {
  final String title;
  final String releaseDate;
  final String genre;
  final String imageUrl;
  final bool isExclusive;
  final bool isImax;

  const _ComingSoonCard({
    required this.title,
    required this.releaseDate,
    required this.genre,
    required this.imageUrl,
    required this.isExclusive,
    required this.isImax,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withValues(alpha: 0.9),
              Colors.black.withValues(alpha: 0.1),
            ],
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                if (isExclusive) ...[
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
                  const SizedBox(width: 6),
                ],
                if (isImax)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
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
              title,
              style: AppTypography.titleMd.copyWith(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$releaseDate • $genre',
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

class _NowPlayingSection extends StatelessWidget {
  final List<Movie> movies;

  const _NowPlayingSection({required this.movies});

  @override
  Widget build(BuildContext context) {
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sedang Tayang',
<<<<<<< HEAD
          style: AppTypography.titleMd.copyWith(color: Colors.white, fontSize: 22),
=======
          style: AppTypography.titleMd.copyWith(color: Colors.white),
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
<<<<<<< HEAD
            childAspectRatio: 0.55, // Disesuaikan agar muat untuk teks dan gambar
            crossAxisSpacing: 16,
            mainAxisSpacing: 24,
          ),
          itemCount: nowPlayingMovies.length,
          itemBuilder: (context, index) {
            final movie = nowPlayingMovies[index];
            return _buildGridMovieCard(movie, context);
          },
=======
            childAspectRatio: 0.55,
            crossAxisSpacing: 16,
            mainAxisSpacing: 24,
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieGridCard(movie: movies[index]),
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a
        ),
      ],
    );
  }
<<<<<<< HEAD

  /// Card untuk setiap film di Grid
  Widget _buildGridMovieCard(Movie movie, BuildContext context) {
=======
}

class _MovieGridCard extends StatelessWidget {
  final Movie movie;

  const _MovieGridCard({required this.movie});

  @override
  Widget build(BuildContext context) {
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/detail-page", arguments: movie);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
<<<<<<< HEAD
              borderRadius: BorderRadius.circular(12),
=======
              borderRadius: BorderRadius.circular(8),
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    movie.imageUrl,
                    fit: BoxFit.cover,
<<<<<<< HEAD
                    errorBuilder: (_, __, ___) => Container(color: AppColors.neutral.elevated),
=======
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.neutral.elevated,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColors.neutral.onMuted,
                      ),
                    ),
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
<<<<<<< HEAD
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(6),
=======
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: AppColors.glass.border),
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
<<<<<<< HEAD
                          Icon(Icons.star, size: 12, color: AppColors.brand.tertiary),
                          const SizedBox(width: 4),
                          Text(
                            movie.rating.toString(),
                            style: AppTypography.labelSm.copyWith(color: Colors.white),
=======
                          Icon(
                            Icons.star,
                            size: 14,
                            color: AppColors.brand.tertiary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            movie.rating.toString(),
                            style: AppTypography.labelSm.copyWith(
                              color: Colors.white,
                            ),
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a
                          ),
                        ],
                      ),
                    ),
<<<<<<< HEAD
                  )
=======
                  ),
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a
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
<<<<<<< HEAD
            '${movie.genres.join(', ')} • ${movie.durationMinutes}m',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.labelSm.copyWith(color: AppColors.neutral.onMuted),
=======
            '${movie.genres.join(', ')} • ${movie.durationMinutes ~/ 60}h ${movie.durationMinutes % 60}m',
            style: AppTypography.labelSm.copyWith(
              color: AppColors.neutral.onMuted,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a
          ),
        ],
      ),
    );
  }
}

<<<<<<< HEAD
/// =====================================================
/// Bottom Navigation Bar (Khusus State "Movies" Aktif)
/// =====================================================
class _BottomNavBarMovies extends StatelessWidget {
  const _BottomNavBarMovies();
=======
class _BottomNavBar extends StatelessWidget {
  final String activeTab;
  const _BottomNavBar({required this.activeTab});
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a

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
<<<<<<< HEAD
                _NavBarItem(icon: Icons.home_outlined, label: 'Beranda', active: false, route: '/homepage'),
                // "Movies" diset active = true
                _NavBarItem(icon: Icons.movie_filter, label: 'Movies', active: true, route: '/movies'),
                _NavBarItem(icon: Icons.theaters_outlined, label: 'Cinemas', active: false, route: '/cinemas'),
                _NavBarItem(icon: Icons.person_outline, label: 'Profil', active: false, route: 'ticket-history'),
=======
                _NavBarItem(
                  icon: Icons.home,
                  label: 'Beranda',
                  active: activeTab == 'Beranda',
                  route: '/homepage',
                ),
                _NavBarItem(
                  icon: Icons.movie_filter_outlined,
                  label: 'Movies',
                  active: activeTab == 'Movies',
                  route: '/movies',
                ),
                _NavBarItem(
                  icon: Icons.theaters_outlined,
                  label: 'Cinemas',
                  active: activeTab == 'Cinemas',
                  route: '/cinemas',
                ),
                _NavBarItem(
                  icon: Icons.person_outline,
                  label: 'Profil',
                  active: activeTab == 'Profil',
                  route: '',
                ),
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a
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
<<<<<<< HEAD
          // Navigasi ke rute lain tanpa animasi default bawaan agar terlihat seperti ganti tab
=======
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a
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
<<<<<<< HEAD
}
=======
}
>>>>>>> e9d6f569bcf030ab296b523d347e4c8200b8248a
