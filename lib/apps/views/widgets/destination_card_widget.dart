import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/models/destination_model.dart';
import 'package:healing_apps/apps/providers/favorites_provider.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:healing_apps/apps/views/widgets/circle_button_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// A widget that displays a single destination card.
/// It's connected to Riverpod to manage favorite state.
class DestinationCardWidget extends ConsumerWidget {
  final Destination destination;

  const DestinationCardWidget({super.key, required this.destination});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Ambil state dan notifier dari provider
    final favoriteList = ref.watch(favoritesProvider);
    // 2. Tentukan status favorit berdasarkan daftar yang dipantau.
    final isFavorite = favoriteList.any((d) => d.uuid == destination.uuid);

    // Gunakan ref.read di dalam callback/fungsi, bukan untuk membangun UI.
    final favoritesNotifier = ref.read(favoritesProvider.notifier);

    return SizedBox(
      width: 260, // Memberi lebar tetap pada kartu
      child: InkWell(
        onTap: () {
          context.push('/destination-details', extra: destination);
        },
        child: Card(
          color: AppColors.card,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar dan Tombol Favorit
              Stack(
                children: [
                  Image.network(
                    destination.mainImageUrl, // Menggunakan getter yang benar
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 250,
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(PhosphorIconsRegular.imageBroken),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: CircleButtonWidget(
                      // 2. Panggil notifier saat tombol ditekan
                      onPressed: () =>
                          favoritesNotifier.toggleFavorite(destination),
                      // 3. Tampilkan ikon berdasarkan state dari provider
                      icon: isFavorite
                          ? PhosphorIconsFill.heart
                          : PhosphorIconsRegular.heart,
                      // Memberi warna merah jika favorit
                      iconColor: isFavorite ? Colors.red : AppColors.contrast,
                    ),
                  ),
                ],
              ),
              // Detail Teks
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            destination.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              PhosphorIconsFill.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              destination.rating.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          PhosphorIconsRegular.mapPin,
                          color: Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            destination.location,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
