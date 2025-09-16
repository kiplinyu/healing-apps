import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:healing_apps/apps/views/widgets/button_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NotFoundWidget extends StatelessWidget {
  final String text;
  final String imagePath;
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final bool showAppBar;
  final String? appBarTitle;
  final VoidCallback? onBackButtonPressed;

  const NotFoundWidget({
    super.key,
    required this.text,
    required this.imagePath,
    required this.buttonText,
    this.onButtonPressed,
    this.showAppBar = false,
    this.appBarTitle,
    this.onBackButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    // final subtitleStyle = TextStyle(fontSize: 16, color: Colors.grey[600]);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: showAppBar
          ? AppBar(
              title: Text(
                appBarTitle ?? '',
                style: const TextStyle(
                  color: AppColors.text,
                  fontFamily: 'SFUI',
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  PhosphorIconsRegular.caretLeft,
                  color: AppColors.text,
                ),
                onPressed: () {
                  if (onBackButtonPressed != null) {
                    onBackButtonPressed!();
                  } else {
                    // Default back button behavior
                    if (Navigator.canPop(context)) {
                      Navigator.of(context).pop();
                    }
                  }
                },
              ),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.placeholder,
                fontFamily: 'SFUI',
              ),
            ),
            const SizedBox(height: 24),
            Image.asset(
              imagePath,
              width: 250,
              // Add a fallback in case the image fails to load
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.image_not_supported,
                  size: 250,
                  color: AppColors.placeholder,
                );
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ButtonWidget(
                onPressed: () {
                  if (onButtonPressed != null) {
                    onButtonPressed!();
                  } else {
                    context.go('/home');
                  }
                },
                text: buttonText,
                isPrimary: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
