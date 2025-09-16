// ignore_for_file: deprecated_member_use

import 'dart:ui'; // Diperlukan untuk ImageFilter
import 'package:flutter/material.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:healing_apps/apps/views/widgets/circle_button_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// A card widget that displays destination info with a glassmorphism effect.
///
/// This widget layers a blurred, semi-transparent container over a background
/// image to create a frosted glass effect for the text details.
/// It now gracefully handles image loading errors by changing text colors.
class GlassDestinationCardWidget extends StatefulWidget {
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
  State<GlassDestinationCardWidget> createState() =>
      _GlassDestinationCardWidgetState();
}

class _GlassDestinationCardWidgetState
    extends State<GlassDestinationCardWidget> {
  bool _imageHasError = false;

  @override
  Widget build(BuildContext context) {
    final Color textColor = _imageHasError
        ? AppColors.text
        : AppColors.whiteText;
    final Color secondaryTextColor = _imageHasError
        ? AppColors.placeholder
        : Colors.white.withOpacity(0.9);
    final Color glassColor = _imageHasError
        ? Colors.white.withOpacity(0.7)
        : Colors.white.withOpacity(0.25);

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      elevation: 4,
      shadowColor: AppColors.contrast.withOpacity(0.2),
      child: Stack(
        children: [
          // --- 1. Gambar Latar Belakang ---
          Positioned.fill(
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Gunakan postFrameCallback untuk update state secara aman
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted && !_imageHasError) {
                    setState(() {
                      _imageHasError = true;
                    });
                  }
                });
                // Tampilkan UI alternatif jika gambar gagal dimuat
                return Container(
                  color: Colors.grey.shade200, // Background abu-abu
                  child: const Center(
                    child: Icon(
                      PhosphorIconsRegular.imageBroken,
                      color: AppColors.text, // Ikon warna gelap
                      size: 40,
                    ),
                  ),
                );
              },
            ),
          ),

          // --- 2. Tombol Favorit di Kanan Atas ---
          Positioned(
            top: 16,
            right: 16,
            child: CircleButtonWidget(
              onPressed: widget.onFavoriteTap,
              icon: widget.isFavorite
                  ? PhosphorIconsFill.heart
                  : PhosphorIconsRegular.heart,
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
                // Nonaktifkan blur jika gambar error agar tidak aneh
                filter: _imageHasError
                    ? ImageFilter.blur(sigmaX: 0, sigmaY: 0)
                    : ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: glassColor, // Gunakan warna dinamis
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.name,
                              style: TextStyle(
                                color: textColor, // Warna dinamis
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            PhosphorIconsRegular.star,
                            color: textColor, // Warna dinamis
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.rating.toString(),
                            style: TextStyle(
                              color: textColor, // Warna dinamis
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.location,
                        style: TextStyle(
                          color: secondaryTextColor, // Warna dinamis
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
