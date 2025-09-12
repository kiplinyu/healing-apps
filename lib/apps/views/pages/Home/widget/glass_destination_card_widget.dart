import 'dart:ui'; // Diperlukan untuk ImageFilter
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// A card widget that displays destination info with a glassmorphism effect.
///
/// This widget layers a blurred, semi-transparent container over a background
/// image to create a frosted glass effect for the text details.
class GlassDestinationCardWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String location;
  final double rating;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  const GlassDestinationCardWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.rating,
    this.isFavorite = false,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.2),
      child: Stack(
        children: [
          // --- 1. Gambar Latar Belakang ---
          Positioned.fill(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(PhosphorIconsRegular.imageBroken),
                );
              },
            ),
          ),

          // --- 2. Tombol Favorit di Kanan Atas ---
          Positioned(
            top: 16,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.9),
              child: IconButton(
                icon: Icon(
                  isFavorite
                      ? PhosphorIconsFill.heart
                      : PhosphorIconsRegular.heart,
                  color: isFavorite ? Colors.red : Colors.black54,
                ),
                onPressed: onFavoriteTap,
              ),
            ),
          ),

          // --- 3. Kotak Info dengan Efek Kaca di Bawah ---
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Baris Nama dan Rating
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            PhosphorIconsFill.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            rating.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Lokasi
                      Text(
                        location,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
