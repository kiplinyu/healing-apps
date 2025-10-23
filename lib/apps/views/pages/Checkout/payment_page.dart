import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/providers/cart_provider.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PaymentPage extends ConsumerWidget
{
    const PaymentPage({super.key});

    @override
    Widget build(BuildContext context, WidgetRef ref)
    {
        // Ambil data dari cart provider untuk kalkulasi
        final cartNotifier = ref.read(cartProvider.notifier);
        final subtotal = cartNotifier.totalCost;
        final serviceFee = 15000.0; // Contoh service fee
        final totalPayment = subtotal + serviceFee;
        final totalItems = ref.watch(cartProvider).length;

        return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
                title: const Text(
                    'Complete Your Payment',
                    style: TextStyle(color: AppColors.text),
                ),
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
            body: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                    _buildSummaryCard(totalItems, subtotal, serviceFee, totalPayment),
                    const SizedBox(height: 24),
                    // const Text(
                    //     'Choose Payment Method',
                    //     style: TextStyle(
                    //         fontSize: 18,
                    //         fontWeight: FontWeight.bold,
                    //         color: AppColors.text,
                    //     ),
                    // ),
                    // const SizedBox(height: 16),

                    // gw ubah jadi via midtrans aja di ganti jadi button Checkout ke Midtrans
                    _buildCheckoutButton(context, totalPayment),

                    // _buildPaymentMethodTile(
                    //   icon: PhosphorIconsFill.wallet,
                    //   title: 'E-Wallet (GoPay, OVO, etc.)',
                    //   onTap: () {
                    //     // TODO: Implement Midtrans Webview for E-Wallet
                    //   },
                    // ),
                    // const SizedBox(height: 12),
                    // _buildVirtualAccountAccordion(),
                ],
            ),
        );
    }

    Widget _buildCheckoutButton(BuildContext context, double totalPayment)
    {
        final currencyFormatter = NumberFormat.currency(
            locale: 'id_ID',
            symbol: 'Rp. ',
            decimalDigits: 0,
        );

        return ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                ),
            ),
            child: Text(
                'Checkout Now (${currencyFormatter.format(totalPayment)})',
                // text color putih
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                ),
            ),
            onPressed: ()
            {
              context.push('/midtrans-payment');
            }
        );
    }

    /// Widget untuk kartu ringkasan pembayaran
    Widget _buildSummaryCard(
        int totalItems,
        double subtotal,
        double serviceFee,
        double totalPayment,
    )
    {
        final currencyFormatter = NumberFormat.currency(
            locale: 'id_ID',
            symbol: 'Rp. ',
            decimalDigits: 0,
        );

        return Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    const Text(
                        'Summary Payment',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                        ),
                    ),
                    const SizedBox(height: 16),
                    _buildSummaryRow(
                        'Subtotal ($totalItems items)',
                        currencyFormatter.format(subtotal),
                    ),
                    const SizedBox(height: 8),
                    _buildSummaryRow('Service Fee', currencyFormatter.format(serviceFee)),
                    const Divider(height: 24),
                    _buildSummaryRow(
                        'Total Payment',
                        currencyFormatter.format(totalPayment),
                        isTotal: true,
                    ),
                ],
            ),
        );
    }

    /// Helper untuk membuat baris di ringkasan pembayaran
    Widget _buildSummaryRow(String label, String value, {bool isTotal = false})
    {
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Text(
                    label,
                    style: TextStyle(
                        fontSize: 14,
                        color: isTotal ? AppColors.text : AppColors.placeholder,
                    ),
                ),
                Text(
                    value,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isTotal ? AppColors.primary : AppColors.text,
                    ),
                ),
            ],
        );
    }

}
