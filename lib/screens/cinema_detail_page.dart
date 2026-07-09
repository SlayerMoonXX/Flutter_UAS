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
            // --- HEADER POSTER UTAMA ---
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
                        children: [buildTag(cinema.tags[0])],
                      ),
                      const SizedBox(height: 16),
                      Text(cinema.name, style: AppTypography.headlineLgMobile),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            Icons.pin_drop_outlined,
                            size: 20,
                            color: AppColors.brand.primarySoft,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            cinema.address,
                            style: AppTypography.bodyMd.copyWith(
                              color: AppColors.brand.primarySoft,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // --- SECTION: FASILITAS CINEMA ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: buildFacilitiesCard(),
            ),
            const SizedBox(height: 24),

            //Section Tayangan
            // --- SECTION: FILM YANG SEDANG TAYANG ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Sedang Tayang",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Lihat Semua",
                    style: TextStyle(
                      color: AppColors.brand.primarySoft,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 270,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                // 1. FIX: Ubah jumlah item sesuai dengan data film yang ada di bioskop ini
                itemCount: cinema.currentMovies.length,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  // 2. FIX: Ambil data film aktif berdasarkan index looping
                  final movie = cinema.currentMovies[index];

                  // Ambil tag bioskop pertama dari film (atau default ke REGULAR jika kosong)
                  final classType = movie.availableCinemas.isNotEmpty
                      ? movie.availableCinemas.first.classType
                      : 'REGULAR';

                  return buildMovieCard(
                    imageUrl: movie.imageUrl, // Ambil dari model baru
                    tagText: classType,
                    tagColor: classType == 'PREMIERE'
                        ? Colors.amber.shade900
                        : classType == 'IMAX'
                        ? Colors.red.shade900
                        : Colors.grey.shade800,
                    title: movie.title, // Ambil dari model baru
                    genre: movie.genres.join(', '), // Ambil dari model baru
                    duration: movie.durationMinutes, // Ambil dari model baru
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget buildMovieCard({
    required String imageUrl,
    required String tagText,
    required Color tagColor,
    required String title,
    required String genre,
    required int duration,
  }) {
    return SizedBox(
      width: 180,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Image.asset(
              imageUrl,
              height: 270,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.8),
                    ],
                    stops: const [0.6, 1.0],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: tagColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      tagText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$genre • $duration Menit",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFacilitiesCard() {
    final List<Map<String, dynamic>> facilities = [
      {"icon": Icons.local_parking, "text": "Parkir Luas"},
      {"icon": Icons.restaurant, "text": "Food Court"},
      {"icon": Icons.accessible, "text": "Akses Kursi Roda"},
      {"icon": Icons.wc, "text": "Toilet Bersih"},
      {"icon": Icons.local_cafe, "text": "Cafe & Lounge"},
      {"icon": Icons.confirmation_number, "text": "Self Ticketing"},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Fasilitas Cinema",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.white12, thickness: 1),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 3.5,
            ),
            itemCount: facilities.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Icon(
                    facilities[index]["icon"],
                    color: const Color(0xFF90CAF9),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      facilities[index]["text"],
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
