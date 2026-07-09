import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
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
                _GenreFilters(),
                const SizedBox(height: 24),
                _ComingSoonSection(),
                const SizedBox(height: 32),
                _NowPlayingSection(movies: nowPlaying),
              ],
            ),
          ),
        ),
      ),
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
        ),
      ),
    );
  }
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PREMIUM SNEAK PEEK',
          style: AppTypography.labelSm.copyWith(
            color: AppColors.brand.primary,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Coming Soon',
              style: AppTypography.titleMd.copyWith(color: Colors.white),
            ),
            Row(
              children: [
                Text(
                  'Lihat Semua',
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
          ),
        ),
      ],
    );
  }
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sedang Tayang',
          style: AppTypography.titleMd.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.55,
            crossAxisSpacing: 16,
            mainAxisSpacing: 24,
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieGridCard(movie: movies[index]),
        ),
      ],
    );
  }
}

class _MovieGridCard extends StatelessWidget {
  final Movie movie;

  const _MovieGridCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/detail-page", arguments: movie);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    movie.imageUrl,
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
            '${movie.genres.join(', ')} • ${movie.durationMinutes ~/ 60}h ${movie.durationMinutes % 60}m',
            style: AppTypography.labelSm.copyWith(
              color: AppColors.neutral.onMuted,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
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
