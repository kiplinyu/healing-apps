import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healing_apps/apps/models/cart_model.dart';
import 'package:healing_apps/apps/providers/cart_provider.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CartItemCardWidget extends ConsumerWidget
{
    final CartItem cartItem;

    const CartItemCardWidget({super.key, required this.cartItem});

    @override
    Widget build(BuildContext context, WidgetRef ref) 
    {
        final destination = cartItem.destination;
        final formattedDate = DateFormat(
            'dd MMM yyyy',
        ).format(cartItem.selectedDate);
        final formattedPrice = NumberFormat.decimalPattern(
            'id_ID',
        ).format(destination.price);

        return Card(
            color: AppColors.card,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            elevation: 2,
            shadowColor: Colors.black.withOpacity(0.05),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    // Gambar di Kiri
                    Image.network(
                        destination.mainImageUrl,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace)
                        {
                            return Container(
                                width: 150,
                                height: 150,
                                color: Colors.grey[200],
                                child: const Icon(PhosphorIconsRegular.imageBroken),
                            );
                        },
                    ),
                    // Detail di Kanan
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                        destination.name,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.text,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),
                                    _buildInfoRow(PhosphorIconsRegular.calendar, formattedDate),
                                    const SizedBox(height: 4),
                                    _buildInfoRow(
                                        PhosphorIconsRegular.mapPin,
                                        destination.location,
                                    ),
                                    const SizedBox(height: 4),
                                    _buildInfoRow(
                                        PhosphorIconsRegular.ticket,
                                        '${cartItem.quantity} Tickets',
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                            Text(
                                                'Rp$formattedPrice',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.text,
                                                ),
                                            ),
                                            SizedBox(
                                                height: 32,
                                                child: ElevatedButton(
                                                    onPressed: ()
                                                    {
                                                        // Panggil notifier untuk menghapus item
                                                        ref
                                                            .read(cartProvider.notifier)
                                                            .removeFromCart(cartItem);
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor: AppColors.primary.withOpacity(0.1),
                                                        foregroundColor: AppColors.primary,
                                                        elevation: 0,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(8),
                                                        ),
                                                    ),
                                                    child: const Text(
                                                        'Remove',
                                                        style: TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                ),
                                            ),
                                        ],
                                    ),
                                ],
                            ),
                        ),
                    ),
                ],
            ),
        );
    }

    /// Helper widget untuk membuat baris info dengan ikon
    Widget _buildInfoRow(IconData icon, String text) 
    {
        return Row(
            children: [
                Icon(icon, size: 14, color: AppColors.placeholder),
                const SizedBox(width: 8),
                Expanded(
                    child: Text(
                        text,
                        style: const TextStyle(fontSize: 12, color: AppColors.placeholder),
                        overflow: TextOverflow.ellipsis,
                    ),
                ),
            ],
        );
    }
}
