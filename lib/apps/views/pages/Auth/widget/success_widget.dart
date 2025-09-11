import 'package:flutter/material.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';

class SuccessWidget extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const SuccessWidget({
    super.key,
    required this.title,
    required this.description,
    this.icon = Icons.email_outlined, // Default icon
  });

  @override
  Widget build(BuildContext context) {
    // Dialog adalah widget dasar yang memberikan bentuk popup standar
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          24.0,
        ), // Sesuai gambar, sudutnya tumpul
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: contentBox(context),
    );
  }

  // Ini adalah isi dari dialognya
  Widget contentBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Membuat ukuran column sesuai isinya
        children: <Widget>[
          // Lingkaran Oranye dengan Ikon
          CircleAvatar(
            backgroundColor: AppColors.primary,
            radius: 30,
            child: Icon(icon, color: AppColors.whiteText, size: 28),
          ),
          const SizedBox(height: 24),
          // Judul Dialog
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              color: AppColors.text,
              fontWeight: FontWeight.w600,
              fontFamily: 'SFUI', // Menggunakan font dari kodemu
            ),
          ),
          const SizedBox(height: 12),
          // Deskripsi Dialog
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.placeholder,
              fontWeight: FontWeight.w500,
              fontFamily: 'SFUI',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
