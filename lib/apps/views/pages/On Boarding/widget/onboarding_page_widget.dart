import 'package:flutter/material.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import '../data/onboarding_items.dart';

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingItem item;
  final Widget? bottomWidget;

  const OnboardingPageWidget({
    super.key,
    required this.item,
    this.bottomWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Gambar
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
          child: Image.asset(
            item.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.52,
          ),
        ),
        const SizedBox(height: 24),

        /// Title + Highlight Responsif
        LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth * 0.8; // 80% dari layar
            final baseSize = 32.0;
            final fontSize = constraints.maxWidth < 320
                ? baseSize * 0.8
                : constraints.maxWidth > 600
                ? baseSize * 1.2
                : baseSize;

            return SizedBox(
              width: maxWidth,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'SFUI',
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                    color: AppColors.text,
                  ),
                  children: [
                    TextSpan(text: item.title),
                    TextSpan(
                      text: item.highlight,
                      style: const TextStyle(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 24),

        /// Description Responsif
        LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth * 0.85; // 85% dari layar
            final baseSize = 16.0;
            final fontSize = constraints.maxWidth < 320
                ? baseSize * 0.9
                : constraints.maxWidth > 600
                ? baseSize * 1.1
                : baseSize;

            return SizedBox(
              width: maxWidth,
              child: Text(
                item.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'SFUI',
                  fontSize: fontSize,
                  fontWeight: FontWeight.w300,
                  color: AppColors.placeholder,
                ),
              ),
            );
          },
        ),

        if (bottomWidget != null) bottomWidget!,
      ],
    );
  }
}
