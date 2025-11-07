// ignore_for_file: deprecated_member_use

import 'dart:ui'; // Diperlukan untuk ImageFilter
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/models/destination_model.dart';
import 'package:healing_apps/apps/providers/favorites_provider.dart';
// --- DIPERBAIKI: Menggunakan ':' bukan '.' ---
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:healing_apps/apps/views/widgets/circle_button_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// A card widget that displays destination info with a glassmorphism effect.
/// It is connected to Riverpod to manage favorite state and handles image errors.
class GlassDestinationCardWidget extends ConsumerStatefulWidget {
  final Destination destination;

  const GlassDestinationCardWidget({super.key, required this.destination});

  @override
  ConsumerState<GlassDestinationCardWidget> createState() =>
      _GlassDestinationCardWidgetState();
}

class _GlassDestinationCardWidgetState
    extends ConsumerState<GlassDestinationCardWidget> {
  bool _imageHasError = false;

  @override
  Widget build(BuildContext context) {
    // --- Ambil state dan notifier dari Riverpod ---
    final favoriteList = ref.watch(favoritesProvider);
    // 2. Tentukan status favorit berdasarkan daftar yang dipantau.
    final isFavorite = favoriteList.any((d) => d.uuid == widget.destination.uuid);

    // Gunakan ref.read di dalam callback/fungsi, bukan untuk membangun UI.
    final favoritesNotifier = ref.read(favoritesProvider.notifier);

    // --- Logika untuk mengubah warna teks saat gambar error ---
    final Color textColor = _imageHasError
        ? AppColors.text
        : AppColors.whiteText;
    final Color secondaryTextColor = _imageHasError
        ? AppColors.placeholder
        : Colors.white.withOpacity(0.9);
    final Color glassColor = _imageHasError
        ? Colors.white.withOpacity(0.7)
        : Colors.white.withOpacity(0.25);

    return InkWell(
      onTap: () {
        context.push('/destination-details', extra: widget.destination);
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        elevation: 4,
        shadowColor: AppColors.contrast.withOpacity(0.2),
        child: Stack(
          children: [
            // --- 1. Gambar Latar Belakang ---
            Positioned.fill(
              child: Image.network(
                widget.destination.mainImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted && !_imageHasError) {
                      setState(() {
                        _imageHasError = true;
                      });
                    }
                  });
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(
                        PhosphorIconsRegular.imageBroken,
                        color: AppColors.text,
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
                onPressed: () =>
                    favoritesNotifier.toggleFavorite(widget.destination),
                icon: isFavorite
                    ? PhosphorIconsFill.heart
                    : PhosphorIconsRegular.heart,
                iconColor: isFavorite ? Colors.red : AppColors.contrast,
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
                  filter: _imageHasError
                      ? ImageFilter.blur(sigmaX: 0, sigmaY: 0)
                      : ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: glassColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.destination.name,
                                style: TextStyle(
                                  color: textColor,
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
                              color: textColor,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.destination.rating.toString(),
                              style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.destination.location,
                          style: TextStyle(
                            color: secondaryTextColor,
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
      ),
    );
  }
}
