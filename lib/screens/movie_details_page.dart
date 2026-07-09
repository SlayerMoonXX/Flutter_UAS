import 'dart:ui';

import 'package:flutter/material.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({super.key});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetailsPage> {
  @override
  Widget build(BuildContext context) {
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
              title: const Text("Movie Detail"),
              leading: IconButton(
                style: IconButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(8),
                  side: const BorderSide(width: 1, color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
              //icon lovca
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.heart_broken),
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
          crossAxisAlignment: .start,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/jpg/reze-poster.jpg',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                Positioned(
                  bottom: 20,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: .start,
                    mainAxisSize: .min,
                    children: [
                      //tag
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: [
                          _buildTag("Supranatural"),
                          _buildTag("Action"),
                          _buildTagWithIcon(Icons.star, "4.9"),
                          _buildTag("101 Min"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//component tag biar gak capek
Widget _buildTag(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1),
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
      border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1),
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
