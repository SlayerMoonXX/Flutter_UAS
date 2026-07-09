// model/cinema_model.dart
import 'movie_model.dart';

class Cinema {
  final String id;
  final String name;
  final String address;
  final double distanceKm;
  final String cityArea; // e.g., 'Jakarta Pusat'
  final List<String> tags; // ['IMAX', 'PREMIERE']
  final List<String> facilities; // ['Parkir Luas', 'Food Court', dll]
  // Menyimpan film apa saja yang sedang tayang di bioskop ini (untuk page 2)
  final List<Movie> currentMovies; 

  Cinema({
    required this.id,
    required this.name,
    required this.address,
    required this.distanceKm,
    required this.cityArea,
    required this.tags,
    required this.facilities,
    required this.currentMovies,
  });
}