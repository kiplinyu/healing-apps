import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healing_apps/apps/providers/cart_provider.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PaymentPage extends ConsumerWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          const Text(
            'Choose Payment Method',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 16),
          _buildPaymentMethodTile(
            icon: PhosphorIconsFill.wallet,
            title: 'E-Wallet (GoPay, OVO, etc.)',
            onTap: () {
              // TODO: Implement Midtrans Webview for E-Wallet
            },
          ),
          const SizedBox(height: 12),
          _buildVirtualAccountAccordion(),
        ],
      ),
    );
  }

  /// Widget untuk kartu ringkasan pembayaran
  Widget _buildSummaryCard(
    int totalItems,
    double subtotal,
    double serviceFee,
    double totalPayment,
  ) {
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
  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
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

  /// Widget untuk tile metode pembayaran biasa
  Widget _buildPaymentMethodTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: const TextStyle(color: AppColors.text)),
      trailing: const Icon(
        PhosphorIconsRegular.caretRight,
        color: AppColors.placeholder,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.placeholder, width: 0.5),
      ),
      onTap: onTap,
    );
  }

  /// Widget untuk accordion Virtual Account
  Widget _buildVirtualAccountAccordion() {
    return Card(
      color: AppColors.card,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.placeholder, width: 0.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: const Icon(Icons.account_balance, color: AppColors.primary),
        title: const Text(
          'Virtual Account Transfer',
          style: TextStyle(color: AppColors.text),
        ),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'You will be redirected to complete your payment.',
              style: TextStyle(fontSize: 12, color: AppColors.placeholder),
            ),
          ),
          _buildPaymentMethodTile(
            icon: PhosphorIconsFill.bank,
            title: 'BCA Virtual Account',
            onTap: () {
              // TODO: Implement Midtrans Webview for BCA VA
            },
          ),
          _buildPaymentMethodTile(
            icon: PhosphorIconsFill.bank,
            title: 'BNI Virtual Account',
            onTap: () {
              // TODO: Implement Midtrans Webview for BNI VA
            },
          ),
          _buildPaymentMethodTile(
            icon: PhosphorIconsFill.bank,
            title: 'Mandiri Virtual Account',
            onTap: () {
              // TODO: Implement Midtrans Webview for Mandiri VA
            },
          ),
        ],
      ),
    );
  }
}
