// data/dummy_data.dart
import '../models/movie_model.dart';
import '../models/cinema_model.dart';

// 1. Buat objek bioskop kosongan dulu (tanpa list film) untuk referensi awal
final cinemaGI = Cinema(
  id: 'c1',
  name: 'Grand Indonesia Premiere',
  address: 'Jl. M.H. Thamrin No.1, Menteng, Jakarta Pusat',
  distanceKm: 2.4,
  cityArea: 'Jakarta Pusat',
  tags: ['IMAX', 'PREMIERE'],
  facilities: [
    'Parkir Luas',
    'Food Court',
    'Akses Kursi Roda',
    'Toilet Bersih',
  ],
  currentMovies: [], // diisi nanti
);

final cinemaPS = Cinema(
  id: 'c2',
  name: 'Plaza Senayan XXI',
  address: 'Plaza Senayan Lt. 5, Jakarta Selatan',
  distanceKm: 3.1,
  cityArea: 'Jakarta Selatan',
  tags: ['REGULAR'],
  facilities: ['Parkir Luas', 'Toilet Bersih', 'Cafe & Lounge'],
  currentMovies: [],
);

// 2. Buat objek film yang mereferensikan bioskop tadi
final movieStarlight = Movie(
  id: 'm1',
  title: 'Starlight Odyssey: Beyond the Horizon',
  imageUrl: 'assets/starlight.png',
  genres: ['Sci-Fi', 'Adventure'],
  rating: 4.8,
  durationMinutes: 142,
  director: 'Elena Rostova',
  description:
      'When a mysterious signal is detected from the edge of the galaxy...',
  availableCinemas: [
    CinemaShowtime(
      cinema: cinemaGI,
      classType: 'IMAX',
      schedules: ['12:30', '15:15', '18:00', '20:45'],
    ),
    CinemaShowtime(
      cinema: cinemaPS,
      classType: 'REGULAR',
      schedules: ['11:00', '13:45', '16:30', '19:15', '22:00'],
    ),
  ],
);

final movieStellar = Movie(
  id: 'm2',
  title: 'Stellar Voyage',
  imageUrl: 'assets/stellar.png',
  genres: ['Sci-Fi'],
  rating: 4.5,
  durationMinutes: 135,
  director: 'Eliza Reid',
  description: 'The infinite vortex awaits...',
  availableCinemas: [],
);

// 3. Inject kembali film ke dalam list currentMovies milik bioskop
void initDummyData() {
  if (cinemaGI.currentMovies.isEmpty) {
    cinemaGI.currentMovies.addAll([movieStarlight, movieStellar]);
    cinemaPS.currentMovies.addAll([movieStarlight]);
  }
}
