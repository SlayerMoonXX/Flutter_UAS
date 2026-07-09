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
      "Denji faces his deadliest battle yet, fueled by love in a world where survival knows no rules. After meeting Reze, a mysterious girl who works at a café, Denji’s everyday life begins to change dramatically as explosive secrets unfold.",
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

final cinemaGrandCity = Cinema(
  id: 'c1',
  name: 'CinePremium Grand City',
  address: 'Mall Grand City Lt. 4',
  distanceKm: 2.5,
  cityArea: 'Surabaya Pusat', // Sesuaikan area kota jika perlu
  tags: ['IMAX', 'PREMIERE'],
  facilities: ['Parkir Luas', 'Food Court', 'Toilet Bersih'],
  currentMovies: [],
);

final cinemaTownSquare = Cinema(
  id: 'c2',
  name: 'CinePremium Town Square',
  address: 'Town Square Lt. 3',
  distanceKm: 4.1,
  cityArea: 'Surabaya Selatan',
  tags: ['REGULAR'],
  facilities: ['Parkir Luas', 'Toilet Bersih'],
  currentMovies: [],
);

// 2. DAFTARKAN FILM DARI TEMENMU (Ubah ke Class Movie kita)
final movieAvatar = Movie(
  id: 'm1',
  title: 'Avatar: The Last Airbender',
  imageUrl: 'assets/png/avatar.png', // Ikut path temenmu
  genres: ['Fantasy'],
  rating: 4.6,
  durationMinutes: 135,
  director: 'Albert Kim',
  description:
      'A young boy known as the Avatar must master the four elemental powers to save a world at war.',
  availableCinemas: [
    CinemaShowtime(
      cinema: cinemaGrandCity,
      classType: 'IMAX',
      schedules: ['12:30', '15:15', '18:00', '20:45'],
    ),
    CinemaShowtime(
      cinema: cinemaTownSquare,
      classType: 'REGULAR',
      schedules: ['13:00', '16:30', '19:15'],
    ),
  ],
);

final movieFurious = Movie(
  id: 'm2',
  title: 'The Furious',
  imageUrl: 'assets/png/furious.png',
  genres: ['Action'],
  rating: 4.3,
  durationMinutes: 100,
  director: 'Unknown Director',
  description:
      'An adrenaline-fueled ride through the underground racing circuit.',
  availableCinemas: [
    CinemaShowtime(
      cinema: cinemaGrandCity,
      classType: 'PREMIERE',
      schedules: ['14:00', '18:00'],
    ),
  ],
);

final movieLesson = Movie(
  id: 'm3',
  title: 'Teach You a Lesson',
  imageUrl: 'assets/png/lesson.png',
  genres: ['Thriller'],
  rating: 4.1,
  durationMinutes: 110,
  director: 'Unknown Director',
  description:
      'A suspenseful game of cat and mouse where secrets can be deadly.',
  availableCinemas: [
    CinemaShowtime(
      cinema: cinemaTownSquare,
      classType: 'REGULAR',
      schedules: ['11:00', '15:30', '20:00'],
    ),
  ],
);

final movieKim = Movie(
  id: 'm4',
  title: 'Agent Kim: Reactivated',
  imageUrl: 'assets/png/mrkim.png',
  genres: ['Action'],
  rating: 4.4,
  durationMinutes: 115,
  director: 'Unknown Director',
  description:
      'The top secret agent is pulled out of retirement for one final, dangerous assignment.',
  availableCinemas: [
    CinemaShowtime(
      cinema: cinemaGrandCity,
      classType: 'IMAX',
      schedules: ['13:10', '16:20', '19:30'],
    ),
  ],
);

final movieDune = Movie(
  id: 'm5',
  title: 'Dune: Part Two',
  imageUrl: 'https://image.tmdb.org/t/p/w500/1pdfLvkbY9ohJlCjQH2JGjjc9CW.jpg',
  genres: ['Sci-Fi', 'Adventure'],
  rating: 4.8,
  durationMinutes: 166,
  director: 'Denis Villeneuve',
  description: 'Paul Atreides unites with Chani and the Fremen while on a warpath of revenge against the conspirators who destroyed his family.',
  availableCinemas: [
    CinemaShowtime(cinema: cinemaGrandCity, classType: 'IMAX', schedules: ['14:00', '18:00']),
  ],
);

final movieOppenheimer = Movie(
  id: 'm6',
  title: 'Oppenheimer',
  imageUrl: 'https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg',
  genres: ['Drama', 'History'],
  rating: 4.9,
  durationMinutes: 180,
  director: 'Christopher Nolan',
  description: 'The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb.',
  availableCinemas: [
    CinemaShowtime(cinema: cinemaGI, classType: 'IMAX', schedules: ['10:00', '15:00', '20:00']),
  ],
);

final movieSpiderVerse = Movie(
  id: 'm7',
  title: 'Spider-Man: Across the Spider-Verse',
  imageUrl: 'https://image.tmdb.org/t/p/w500/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg',
  genres: ['Animation', 'Action'],
  rating: 4.7,
  durationMinutes: 140,
  director: 'Joaquim Dos Santos',
  description: 'Miles Morales catapults across the Multiverse, where he encounters a team of Spider-People charged with protecting its very existence.',
  availableCinemas: [
    CinemaShowtime(cinema: cinemaPS, classType: 'REGULAR', schedules: ['12:30', '16:00', '19:30']),
  ],
);

final movieJohnWick = Movie(
  id: 'm8',
  title: 'John Wick: Chapter 4',
  imageUrl: 'https://image.tmdb.org/t/p/w500/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg',
  genres: ['Action', 'Thriller'],
  rating: 4.5,
  durationMinutes: 169,
  director: 'Chad Stahelski',
  description: 'John Wick uncovers a path to defeating The High Table.',
  availableCinemas: [
    CinemaShowtime(cinema: cinemaTownSquare, classType: 'PREMIERE', schedules: ['13:00', '17:30', '21:00']),
  ],
);

// ==========================================
// 3. INJECT FILM KEMBALI KE LIST BIOSKOP
// ==========================================
void initDummyData() {
  // FIX: Cek menggunakan variabel bioskop yang dipakai di Homepage sekarang
  if (cinemaGrandCity.currentMovies.isEmpty) {
    // Isi film ke bioskop Grand City (punya temanmu)
    cinemaGrandCity.currentMovies.addAll([movieAvatar, movieFurious, movieKim]);

    // Isi film ke bioskop Town Square (punya temanmu)
    cinemaTownSquare.currentMovies.addAll([movieAvatar, movieLesson]);
  }
}
