import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_uas/data/dummy_data.dart';
import 'package:flutter_uas/models/ticket_model.dart';
import 'package:flutter_uas/models/movie_model.dart';
import 'package:flutter_uas/theme/app_colors.dart';
import 'package:flutter_uas/theme/app_typography.dart';

/// Argumen yang dikirim dari MovieDetailsPage ke SeatBookingPage
class SeatBookingArgs {
  final Movie movie;
  final String cinemaName;
  final String initialTime;
  final List<String> availableTimes;

  SeatBookingArgs({
    required this.movie,
    required this.cinemaName,
    required this.initialTime,
    required this.availableTimes,
  });
}

class SeatBookingPage extends StatefulWidget {
  const SeatBookingPage({super.key});

  @override
  State<SeatBookingPage> createState() => _SeatBookingPageState();
}

class _SeatBookingPageState extends State<SeatBookingPage> {
  static const int _pricePerSeat = 60000;
  static const List<String> _dayLabels = [
    'Sen',
    'Sel',
    'Rab',
    'Kam',
    'Jum',
    'Sab',
    'Min',
  ];
  static const List<String> _monthLabels = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];

  int _selectedDateIndex = 0;
  late String _selectedTime;
  final Set<String> _selectedSeats = {};

  // Baris kursi & kursi yang sudah terisi (dummy)
  final List<String> _rows = ['A', 'B', 'C', 'D', 'E'];
  final int _seatsPerRow = 8;
  final Set<String> _takenSeats = {'A3', 'A4', 'B5', 'C2', 'C7', 'D6'};

  SeatBookingArgs? _args;

  @override
  Widget build(BuildContext context) {
    if (_args == null) {
      _args = ModalRoute.of(context)!.settings.arguments as SeatBookingArgs;
      _selectedTime = _args!.initialTime;
    }
    final args = _args!;
    final movie = args.movie;

    final total = _selectedSeats.length * _pricePerSeat;

    return Scaffold(
      backgroundColor: AppColors.neutral.base,
      body: Stack(
        children: [
          // ===== Background poster + info film =====
          Column(
            children: [
              SizedBox(
                height: 340,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(movie.imageUrl, fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.55),
                            AppColors.neutral.base,
                          ],
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              style: IconButton.styleFrom(
                                shape: const CircleBorder(),
                                backgroundColor: Colors.black.withValues(
                                  alpha: 0.4,
                                ),
                                padding: const EdgeInsets.all(8),
                              ),
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              movie.title,
                              style: AppTypography.headlineLgMobile,
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              children: movie.genres
                                  .take(2)
                                  .map((g) => _buildTag(g))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),

          // ===== Sheet "Beli Tiket" =====
          Positioned(
            top: 280,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.neutral.base,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
                border: Border(
                  top: BorderSide(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Container(
                    width: 44,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Beli Tiket", style: AppTypography.titleMd),
                          const SizedBox(height: 24),

                          _sectionLabel("Pilih Tanggal"),
                          const SizedBox(height: 12),
                          _buildDateSelector(),
                          const SizedBox(height: 24),

                          _sectionLabel(
                            "Pilih Waktu (${args.cinemaName})",
                          ),
                          const SizedBox(height: 12),
                          _buildTimeSelector(args.availableTimes),
                          const SizedBox(height: 24),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _sectionLabel("Pilih Kursi"),
                              Row(
                                children: [
                                  _buildLegend(
                                    color: AppColors.brand.secondary,
                                    filled: false,
                                    label: "Kosong",
                                  ),
                                  const SizedBox(width: 16),
                                  _buildLegend(
                                    color: AppColors.brand.primary,
                                    filled: true,
                                    label: "Dipilih",
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildSeatMap(),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // ===== Bottom bar total & konfirmasi =====
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        decoration: BoxDecoration(
          color: AppColors.neutral.base,
          border: Border(
            top: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total (${_selectedSeats.length} Kursi)",
              style: AppTypography.bodyMd.copyWith(
                color: AppColors.neutral.onMuted,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatRupiah(total),
              style: AppTypography.headlineLgMobile,
            ),
            const SizedBox(height: 16),
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: _selectedSeats.isNotEmpty
                  ? () {
        final selectedDate = DateTime.now().add(Duration(days: _selectedDateIndex));
        final dateString = "${selectedDate.day} ${_monthLabels[selectedDate.month - 1]} ${selectedDate.year}";
        final seatsString = _selectedSeats.join(', ');
        final uniqueCode = "CINE-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}";

        // 2. BUAT OBJEK TIKET
        final newTicket = Ticket(
          movie: movie,
          cinemaName: args.cinemaName,
          date: dateString,
          time: _selectedTime,
          studio: "Studio 1", 
          seats: seatsString, 
          bookingCode: uniqueCode, 
          isActive: true, 
        );

        // 3. MASUKKAN KE LIST GLOBAL (Paling Penting!)
        listTiketSaya.add(newTicket);

        // 4. TAMPILKAN SNACKBAR
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Berhasil memesan kursi $seatsString!"),
            backgroundColor: AppColors.brand.primary,
          ),
        );

        // 5. KEMBALI KE BERANDA
        Navigator.pushReplacementNamed(context, '/homepage');
      }
    : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: double.infinity,
                height: 55,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _selectedSeats.isNotEmpty
                      ? AppColors.brand.primary
                      : AppColors.neutral.elevated,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Konfirmasi Pembayaran ",
                      style: AppTypography.titleMd.copyWith(
                        color: _selectedSeats.isNotEmpty
                            ? Colors.white
                            : Colors.grey,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: _selectedSeats.isNotEmpty
                          ? Colors.white
                          : Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= Helpers =================

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: AppTypography.labelLg.copyWith(color: AppColors.brand.primarySoft),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    final now = DateTime.now();
    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final date = now.add(Duration(days: index));
          final isSelected = _selectedDateIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedDateIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 72,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.brand.primary.withValues(alpha: 0.15)
                    : const Color(0xFF131313),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected
                      ? AppColors.brand.primary
                      : Colors.white.withValues(alpha: 0.1),
                  width: isSelected ? 2 : 1,
                ),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _dayLabels[date.weekday - 1],
                    style: TextStyle(
                      color: AppColors.brand.primarySoft,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    date.day.toString().padLeft(2, '0'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _monthLabels[date.month - 1],
                    style: TextStyle(
                      color: AppColors.neutral.onMuted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeSelector(List<String> times) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: times.map((t) {
        final isSelected = _selectedTime == t;
        return GestureDetector(
          onTap: () => setState(() => _selectedTime = t),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.brand.primary.withValues(alpha: 0.15)
                  : const Color(0xFF131313),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected
                    ? AppColors.brand.primary
                    : Colors.white.withValues(alpha: 0.1),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Text(
              t,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLegend({
    required Color color,
    required bool filled,
    required String label,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: filled ? color : Colors.transparent,
            border: Border.all(color: color, width: 1.5),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(color: AppColors.neutral.onMuted, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildSeatMap() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF131313),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: [
          // "Layar" berbentuk lengkung
          CustomPaint(
            size: const Size(double.infinity, 30),
            painter: _ScreenCurvePainter(
              color: AppColors.neutral.outline,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "LAYAR",
            style: AppTypography.labelSm.copyWith(
              color: AppColors.neutral.onMuted,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: _rows.map((row) => _buildSeatRow(row)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSeatRow(String row) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
            child: Text(
              row,
              style: TextStyle(color: AppColors.neutral.onMuted, fontSize: 12),
            ),
          ),
          const SizedBox(width: 8),
          ...List.generate(_seatsPerRow, (i) {
            final seatCode = "$row${i + 1}";
            final isTaken = _takenSeats.contains(seatCode);
            final isSelected = _selectedSeats.contains(seatCode);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: GestureDetector(
                onTap: isTaken
                    ? null
                    : () {
                        setState(() {
                          if (isSelected) {
                            _selectedSeats.remove(seatCode);
                          } else {
                            _selectedSeats.add(seatCode);
                          }
                        });
                      },
                child: Container(
                  width: 26,
                  height: 26,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isTaken
                        ? Colors.white.withValues(alpha: 0.06)
                        : isSelected
                            ? AppColors.brand.primary
                            : Colors.transparent,
                    border: Border.all(
                      color: isTaken
                          ? Colors.transparent
                          : isSelected
                              ? AppColors.brand.primary
                              : AppColors.brand.secondary,
                      width: 1.5,
                    ),
                  ),
                  child: isTaken
                      ? Icon(
                          Icons.close,
                          size: 12,
                          color: Colors.white.withValues(alpha: 0.2),
                        )
                      : null,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  String _formatRupiah(int value) {
    final str = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      final posFromEnd = str.length - i;
      buffer.write(str[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1) {
        buffer.write('.');
      }
    }
    return "Rp $buffer";
  }
}

/// Custom painter untuk garis lengkung "LAYAR"
class _ScreenCurvePainter extends CustomPainter {
  final Color color;
  _ScreenCurvePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(size.width * 0.08, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.5,
      -size.height * 0.6,
      size.width * 0.92,
      size.height * 0.7,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ScreenCurvePainter oldDelegate) => false;
}
