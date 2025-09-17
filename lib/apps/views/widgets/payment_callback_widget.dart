import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PaymentCallbackWidget extends StatelessWidget {
  final bool isSuccess;
  final double amount;
  final String transactionId;

  const PaymentCallbackWidget({
    super.key,
    required this.isSuccess,
    required this.amount,
    required this.transactionId,
  });

  @override
  Widget build(BuildContext context) {
    // Tentukan konten dinamis berdasarkan status pembayaran
    final Color iconBgColor = isSuccess
        ? Colors.green.shade100
        : Colors.red.shade100;
    final Color iconColor = isSuccess ? Colors.green : Colors.red;
    final IconData iconData = isSuccess
        ? PhosphorIconsFill.checkCircle
        : PhosphorIconsFill.xCircle;
    final String title = isSuccess
        ? 'Yay! Payment Completed'
        : 'Oops, Your Payment Didn’t Go Through';
    final String message = isSuccess
        ? 'Thanks a lot! We’ve received and confirmed your order.'
        : 'Your balance is not enough. Please top up or use a different payment method.';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              _buildStatusCard(
                iconBgColor,
                iconColor,
                iconData,
                title,
                message,
              ),
              const SizedBox(height: 16),
              if (isSuccess)
                const Text(
                  'We’ve sent your e-ticket and order details to your email. Please check your inbox (or spam folder).',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: AppColors.placeholder),
                ),
              const Spacer(),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget untuk menampilkan kartu status utama
  Widget _buildStatusCard(
    Color iconBgColor,
    Color iconColor,
    IconData iconData,
    String title,
    String message,
  ) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: 0,
    );

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: iconColor, size: 32),
          ),
          const SizedBox(height: 16),
          Text(
            currencyFormatter.format(amount),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.placeholder,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Transaction ID: ',
                  style: TextStyle(color: AppColors.placeholder),
                ),
                Text(
                  transactionId,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Widget untuk membangun tombol aksi di bagian bawah
  Widget _buildActionButtons(BuildContext context) {
    if (isSuccess) {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.go('/home'), // Navigasi ke Home
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.whiteText,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('Back to Home'),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => context.go('/schedule'), // Navigasi ke Schedule
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('View My Schedule'),
            ),
          ),
        ],
      );
    } else {
      // Tombol untuk kondisi gagal
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pop(), // Kembali ke halaman payment
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.whiteText,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('Retry Payment'),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                // TODO: Arahkan ke halaman bantuan atau kontak
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.placeholder,
                side: const BorderSide(color: AppColors.placeholder),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('Need Help?'),
            ),
          ),
        ],
      );
    }
  }
}
// ```

// ### Cara Menggunakannya

// Setelah proses pembayaran di `PaymentWebViewPage` selesai, Anda akan mendapatkan statusnya (sukses atau gagal). Dari sana, Anda akan melakukan navigasi ke halaman baru ini sambil mengirimkan data yang dibutuhkan.

// **Contoh pemanggilan di GoRouter:**

// Pertama, daftarkan rutenya:

// ```dart
// // Di file konfigurasi GoRouter Anda
