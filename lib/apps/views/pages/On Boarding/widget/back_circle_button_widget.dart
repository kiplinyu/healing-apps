import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BackCircleButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color iconColor;

  const BackCircleButtonWidget({
    super.key,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor.withValues(alpha: 102), // 40% opacity
      child: IconButton(
        icon: Icon(
          PhosphorIconsRegular.arrowLeft, // pakai phosphor icon
          color: iconColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
