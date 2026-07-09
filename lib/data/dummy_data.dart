// data/dummy_data.dart
import '../models/movie_model.dart';
import '../models/cinema_model.dart';

// ==========================================
// 1. BUAT OBJEK CINEMA (KOSONGAN DULU)
// ==========================================
final cinemaGI = Cinema(
  id: 'c1',
  name: 'Grand Indonesia Premiere',
  address: 'Jl. M.H. Thamrin No.1, Menteng, Jakarta Pusat, DKI Jakarta 10310',
  distanceKm: 2.4,
  cityArea: 'Jakarta Pusat',
  tags: ['IMAX', 'PREMIERE'],
  facilities: [
    'Parkir Luas',
    'Food Court',
    'Akses Kursi Roda',
    'Toilet Bersih',
    'Cafe & Lounge',
    'Self Ticketing',
  ],
  currentMovies: [], // diisi di langkah 3
);

final cinemaPS = Cinema(
  id: 'c2',
  name: 'Plaza Senayan XXI',
  address: 'Plaza Senayan Lt. 5, Jl. Asia Afrika, Jakarta Selatan',
  distanceKm: 3.1,
  cityArea: 'Jakarta Selatan',
  tags: ['REGULAR'],
  facilities: [
    'Parkir Luas',
    'Toilet Bersih',
    'Cafe & Lounge',
    'Self Ticketing',
  ],
  currentMovies: [], // diisi di langkah 3
);

final cinemaPIM = Cinema(
  id: 'c3',
  name: 'Pondok Indah Mall 2 XXI',
  address: 'Pondok Indah Mall 2 Lt. 3, Jakarta Selatan',
  distanceKm: 5.8,
  cityArea: 'Jakarta Selatan',
  tags: ['DOLBY ATMOS'],
  facilities: ['Parkir Luas', 'Food Court', 'Toilet Bersih'],
  currentMovies: [],
);

// ==========================================
// 2. BUAT OBJEK MOVIE (MEREFERENSIKAN CINEMA)
// ==========================================
final movieChainsawMan = Movie(
  id: 'm1',
  title: 'Chainsaw Man – The Movie: Reze Arc',
  imageUrl: 'assets/jpg/reze-poster.jpg', // Path lokal .jpg
  genres: ['Action', 'Dark Fantasy', 'Gore'],
  rating: 4.9,
  durationMinutes: 100, // 100 Menit sesuai data asli
  director: 'Tatsuya Yoshihara', // Sutradara asli filmnya
  description:
      'Denji faces his deadliest battle yet, fueled by love in a world where survival knows no rules. After meeting Reze, a mysterious girl who works at a café, Denji’s everyday life begins to change dramatically as explosive secrets unfold.',
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
    CinemaShowtime(
      cinema: cinemaPIM,
      classType: 'DOLBY ATMOS',
      schedules: ['14:00', '17:00', '20:00'],
    ),
  ],
);

final movieStarlight = Movie(
  id: 'm2',
  title: 'Starlight Odyssey: Beyond the Horizon',
  imageUrl: 'assets/jpg/starlight_odyssey.jpg', // Path lokal .jpg
  genres: ['Sci-Fi', 'Adventure'],
  rating: 4.8,
  durationMinutes: 142,
  director: 'Elena Rostova',
  description:
      'When a mysterious signal is detected from the edge of the galaxy, a team of elite astronauts embarks on a perilous journey to uncover its origin. What they find will challenge the very fabric of human existence.',
  availableCinemas: [
    CinemaShowtime(
      cinema: cinemaGI,
      classType: 'PREMIERE',
      schedules: ['18:00', '21:00'],
    ),
    CinemaShowtime(
      cinema: cinemaPS,
      classType: 'REGULAR',
      schedules: ['16:30', '19:15'],
    ),
  ],
);

final movieNeonShadows = Movie(
  id: 'm3',
  title: 'Neon Shadows',
  imageUrl: 'assets/jpg/neon_shadows.jpg', // Path lokal .jpg
  genres: ['Thriller', 'Mystery'],
  rating: 4.3,
  durationMinutes: 112,
  director: 'Marcus Vance',
  description:
      'A detective navigates the corrupt underbelly of a rain-slicked cyberpunk metropolis to solve a series of high-profile cybernetic assassinations.',
  availableCinemas: [
    CinemaShowtime(
      cinema: cinemaPS,
      classType: 'REGULAR',
      schedules: ['13:45', '19:15'],
    ),
  ],
);

// ==========================================
// 3. INJECT FILM KEMBALI KE LIST BIOSKOP
// ==========================================
void initDummyData() {
  // Cek biar gak duplikat data kalau fungsi dipanggil tidak sengaja beberapa kali
  if (cinemaGI.currentMovies.isEmpty) {
    cinemaGI.currentMovies.addAll([movieChainsawMan, movieStarlight]);
    cinemaPS.currentMovies.addAll([
      movieChainsawMan,
      movieStarlight,
      movieNeonShadows,
    ]);
    cinemaPIM.currentMovies.addAll([movieChainsawMan]);
  }
}
