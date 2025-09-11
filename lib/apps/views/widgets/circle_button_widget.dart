import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Ganti import di bawah ini dengan path konstanta warna Anda
// import 'package:healing_apps/apps/utils/constant/constants.dart';

class CircleButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;
  final double backgroundOpacity; // 1. Menambahkan parameter untuk opacity

  const CircleButtonWidget({
    super.key,
    required this.onPressed,
    this.backgroundColor = const Color(0xFFFAF7F3),
    // Ganti Colors.black dengan konstanta default Anda, contoh: AppColors.text
    this.iconColor = Colors.black,
    this.icon = PhosphorIconsRegular.arrowLeft,
    this.backgroundOpacity = 0.4, // 2. Memberi nilai default untuk opacity
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      // 3. Opacity diterapkan langsung pada warna background
      //    Ini membuat hanya background yang transparan, bukan isinya (icon).
      // ignore: deprecated_member_use
      backgroundColor: backgroundColor.withOpacity(backgroundOpacity),
      child: IconButton(
        icon: Icon(icon, color: iconColor),
        onPressed: onPressed,
      ),
    );
  }
}
