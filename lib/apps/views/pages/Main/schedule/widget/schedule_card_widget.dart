import 'package:flutter/material.dart';
import 'package:healing_apps/apps/models/cart_model.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// A card widget to display a scheduled item from the cart.
class ScheduleCardWidget extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onShowTicket;
  final VoidCallback onRemove; // Tambahan untuk menghapus item

  const ScheduleCardWidget({
    super.key,
    required this.cartItem,
    required this.onShowTicket,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    // Format tanggal
    final formattedDate = DateFormat(
      'dd MMM yyyy',
    ).format(cartItem.selectedDate);
    // Ambil gambar utama dari destinasi
    final imageUrl = cartItem.destination.mainImageUrl;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: AppColors.card,
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
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(20.0),
            ),
            child: Image.network(
              imageUrl,
              width: 120,
              height: 140,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 120,
                  height: 140,
                  color: Colors.grey[200],
                  child: const Icon(PhosphorIconsRegular.imageBroken),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 108,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItem.destination.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
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
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Tombol Hapus (opsional)
                        TextButton(
                          onPressed: onRemove,
                          child: const Text(
                            'Remove',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: onShowTicket,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.whiteText,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Show Ticket'),
                        ),
                      ],
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
