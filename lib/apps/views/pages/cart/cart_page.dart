import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/providers/cart_provider.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:healing_apps/apps/utils/constant/img_assets.dart';
import 'package:healing_apps/apps/views/pages/Cart/widget/cart_item_card_widget.dart';
import 'package:healing_apps/apps/views/widgets/not_found_widget.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Pantau state dari cartProvider
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Cart', style: TextStyle(color: AppColors.text)),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            PhosphorIconsRegular.caretLeft,
            color: AppColors.text,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: cartItems.isEmpty
          // --- KONDISI JIKA KERANJANG KOSONG ---
          ? const NotFoundWidget(
              text: "Your cart is empty. Let's add some exciting journeys!",
              imagePath: AppAssets.notFoundCart,
              buttonText: "Explore Destinations",
            )
          // --- KONDISI JIKA ADA ITEM DI KERANJANG ---
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return CartItemCardWidget(cartItem: item);
                    },
                  ),
                ),
                // --- Bagian Total Estimasi ---
                _buildEstimatedTotal(context, cartNotifier.totalCost),
              ],
            ),
    );
  }

  /// Widget untuk menampilkan bar total estimasi di bawah
  Widget _buildEstimatedTotal(BuildContext context, double totalCost) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final formattedTotal = currencyFormatter.format(totalCost);

    return Container(
      padding: const EdgeInsets.all(24.0).copyWith(bottom: 32),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Estimated total',
                style: TextStyle(fontSize: 16, color: AppColors.placeholder),
              ),
              Text(
                formattedTotal,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Taxes & additional fees will be calculated at checkout',
            style: TextStyle(fontSize: 12, color: AppColors.placeholder),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Navigasi ke halaman pembayaran
                context.push('/payment');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.whiteText,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('Continue to payment'),
            ),
          ),
        ],
      ),
    );
  }
}
