import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_uas/models/movie_model.dart';
import 'package:flutter_uas/theme/app_colors.dart';
import 'package:flutter_uas/theme/app_typography.dart';
import 'package:flutter_uas/screens/booking_page.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie? movie;
  const MovieDetailsPage({super.key, this.movie});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetailsPage> {
  // Menggunakan fallback data dummy sementara
  String? selectedCinema;
  String? selectedTime;

  @override
  @override
  Widget build(BuildContext context) {
    final activeMovie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: AppBar(
              backgroundColor: Colors.black.withValues(alpha: 0.2),
              elevation: 0,
              centerTitle: true,
              title: Text(
                "Movie Detail",
                style: AppTypography.titleMd.copyWith(
                  color: AppColors.brand.primarySoft,
                ),
              ),
              leading: IconButton(
                style: IconButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(8),
                  side: const BorderSide(width: 1, color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border),
                  style: IconButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(8),
                    side: const BorderSide(width: 1, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // REVISI: Ubah path statis jadi -> activeMovie.imageUrl
                Image.asset(
                  activeMovie.imageUrl,
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
                          _buildTag(activeMovie.genres[0]),
                          _buildTagWithIcon(
                            Icons.star,
                            activeMovie.rating.toString(),
                          ),
                          _buildTag(
                            "${activeMovie.durationMinutes.toString()} Min",
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      //Judul dan desc
                      Text(
                        activeMovie.title,
                        style: AppTypography.headlineLgMobile,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        activeMovie.description,
                        style: AppTypography.bodyMd.copyWith(
                          color: AppColors.brand.primarySoft,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Sutradara: ${activeMovie.director}",
                        style: AppTypography.bodyMd,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            //Setelah image
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.local_movies_outlined,
                        color: AppColors.brand.primary,
                      ),
                      SizedBox(width: 8),
                      Text("Tersedia di Bioskop", style: AppTypography.titleMd),
                    ],
                  ),
                  const SizedBox(height: 16),
                  //List Bioskop
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      children: activeMovie.availableCinemas.map((showtime) {
                        return _buildCinemaCard(
                          showtime.cinema.name,
                          "${showtime.cinema.distanceKm} km • ${showtime.cinema.cityArea}",
                          showtime.classType,
                          showtime.schedules,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      //Butonn Pesen
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 24,
          top: 12,
        ),
        child: InkWell(
          onTap: selectedCinema != null && selectedTime != null
              ? () {
                  // 1. Cari data bioskop yang sedang dipilih untuk mengambil daftar jadwalnya (availableTimes)
        final selectedCinemaData = activeMovie.availableCinemas.firstWhere(
          (showtime) => showtime.cinema.name == selectedCinema,
        );

        // 2. Lakukan navigasi dan kirim argumen menggunakan RouteSettings
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SeatBookingPage(),
            settings: RouteSettings(
              arguments: SeatBookingArgs(
                movie: activeMovie,
                cinemaName: selectedCinema!,
                initialTime: selectedTime!,
                availableTimes: selectedCinemaData.schedules,
              ),
            ),
          ),
        );
                }
              : null,
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
              color: selectedCinema != null && selectedTime != null
                  ? AppColors.brand.primary
                  : AppColors.neutral.elevated,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Pesan Tiket ",
                  style: AppTypography.titleMd.copyWith(
                    color: selectedCinema != null && selectedTime != null
                        ? Colors.white
                        : Colors.grey,
                  ),
                ),
                Icon(
                  Icons.confirmation_number_outlined,
                  color: selectedCinema != null && selectedTime != null
                      ? Colors.white
                      : Colors.grey,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //component tag biar gak capek
  Widget _buildTag(String text) {
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

  // Tag ada ikon
  Widget _buildTagWithIcon(IconData icon, String text, {Color? iconColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: iconColor ?? Colors.white),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: iconColor ?? Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCinemaCard(
    String name,
    String location,
    String tag,
    List<String> times,
  ) {
    // Cek apakah bioskop ini yang sedang dipilih
    final isSelected = selectedCinema == name;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCinema = name;
          selectedTime = null;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF131313),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.brand.primary
                : Colors.white.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      location,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                _buildTag(tag),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: times.map((t) => _buildTimeButton(name, t)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // Helper 2: Tombol Jam Tayang
  Widget _buildTimeButton(String cinemaName, String time) {
    // Jam aktif jika bioskopnya cocok DAN jamnya cocok
    final isTimeSelected = selectedCinema == cinemaName && selectedTime == time;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCinema =
              cinemaName; // Otomatis pilih bioskopnya juga jika jam di-klik
          selectedTime = time;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          // REVISI: Ganti warna background jam jika terpilih
          color: isTimeSelected ? AppColors.brand.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isTimeSelected
                ? AppColors.brand.primary
                : Colors.white.withValues(alpha: 0.2),
          ),
        ),
        child: Text(
          time,
          style: TextStyle(
            // REVISI: Teks jadi putih jika terpilih
            color: isTimeSelected ? Colors.white : Colors.grey,
            fontSize: 13,
            fontWeight: isTimeSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
