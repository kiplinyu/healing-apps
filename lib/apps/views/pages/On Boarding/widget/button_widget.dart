import 'package:flutter/material.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final double? width;
  final double? height;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = false,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isPrimary
              ? AppColors.primary
              : const Color(0xFFE4E5E7),
          foregroundColor: AppColors.text,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: isPrimary
              ? const TextStyle(
                  fontSize: 16,
                  fontFamily: 'SFUI',
                  fontWeight: FontWeight.bold,
                  color: AppColors.whiteText,
                )
              : const TextStyle(
                  fontSize: 16,
                  fontFamily: 'SFUI',
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
        ),
      ),
    );
  }
}
