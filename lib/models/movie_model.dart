// model/movie_model.dart
import 'cinema_model.dart';

class Movie {
  final String id;
  final String title;
  final String imageUrl;
  final List<String> genres;
  final double rating;
  final int durationMinutes;
  final String description;
  final String director;
  // Menyimpan bioskop mana saja yang menayangkan film ini beserta jam tayangnya
  final List<CinemaShowtime> availableCinemas; 

  Movie({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.genres,
    required this.rating,
    required this.durationMinutes,
    required this.description,
    required this.director,
    required this.availableCinemas,
  });
}

class CinemaShowtime {
  final Cinema cinema;
  final String classType; // REGULAR, IMAX, DOLBY ATMOS, 4DX, PREMIERE
  final List<String> schedules;

  CinemaShowtime({
    required this.cinema,
    required this.classType,
    required this.schedules,
  });
}