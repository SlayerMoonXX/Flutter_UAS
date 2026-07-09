import 'package:flutter_uas/models/movie_model.dart';

class Ticket {
  final Movie movie;
  final String cinemaName;
  final String date;
  final String time;
  final String studio;
  final String seats;
  final String bookingCode;
  final bool isActive;

  Ticket({
    required this.movie,
    required this.cinemaName,
    required this.date,
    required this.time,
    required this.studio,
    required this.seats,
    required this.bookingCode,
    this.isActive = true,
  });
}