import 'package:flutter/material.dart';
import 'package:healing_apps/apps/models/destination_model.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart'; // Impor untuk AppColors
import 'package:healing_apps/apps/views/widgets/circle_button_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// A widget that displays a single destination card.
///
/// It takes a [Destination] object and renders the UI based on its data.
class DestinationCardWidget extends StatelessWidget {
  final Destination destination;

  const DestinationCardWidget({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260, // Memberi lebar tetap pada kartu
      child: Card(
        // Menambahkan warna latar belakang dari AppColors
        color: AppColors.card,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        elevation: 0, // Dihilangkan agar sesuai dengan desain baru
        shadowColor: Colors.transparent, // Dihilangkan agar sesuai
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar dan Tombol Favorit
            Stack(
              children: [
                Image.network(
                  destination.imageUrl,
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
                    onPressed: () {},
                    icon: PhosphorIconsRegular.heart,
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
                  // Baris untuk Nama dan Rating (dirapikan)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Expanded agar teks nama tidak overflow jika panjang
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
                      // Rating
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
                  // Baris untuk Lokasi
                  Row(
                    children: [
                      Icon(
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
    );
  }
}
