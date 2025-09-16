import 'package:flutter/material.dart';
import 'package:healing_apps/apps/models/schedule.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// A card widget to display schedule information, updated to the new design.
///
/// It shows the destination image, name, date, and a prominent button to view the ticket.
class ScheduleCardWidget extends StatelessWidget {
  final Schedule schedule;
  final VoidCallback onShowTicket;

  const ScheduleCardWidget({
    super.key,
    required this.schedule,
    required this.onShowTicket,
  });

  @override
  Widget build(BuildContext context) {
    // Format tanggal menjadi "dd MMM yyyy" (contoh: 22 Sep 2025)
    final formattedDate = DateFormat('dd MMM yyyy').format(schedule.date);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: AppColors.card, // Menggunakan warna dari constants
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // --- Gambar di Kiri ---
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(20.0),
            ),
            child: Image.network(
              schedule.imageUrl,
              width: 160,
              height: 140, // Sedikit lebih tinggi untuk estetika
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 160,
                  height: 140,
                  color: Colors.grey[200],
                  child: const Icon(
                    PhosphorIconsRegular.imageBroken,
                    color: AppColors.placeholder,
                  ),
                );
              },
            ),
          ),

          // --- Detail di Kanan ---
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 108, // Memberi tinggi agar tombol pas di bawah
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      schedule.destinationName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: "SFUI",
                        color: AppColors.text,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          PhosphorIconsRegular.calendar,
                          size: 16,
                          color: AppColors.placeholder,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          formattedDate,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.placeholder,
                            fontFamily: "SFUI",
                          ),
                        ),
                      ],
                    ),
                    const Spacer(), // Mendorong tombol ke bawah
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onShowTicket,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.whiteText,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 0, // Desain flat
                        ),
                        child: const Text(
                          'Show Ticket',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: "SFUI",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
