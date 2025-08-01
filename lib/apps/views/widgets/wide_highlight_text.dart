import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';

class WideHighlightText extends StatelessWidget {
  final String textBefore;
  final String highlightedText;
  final String textAfter;
  final String underlineSvgAssetPath;
  final TextStyle? style;
  final TextStyle? highlightStyle;

  const WideHighlightText({
    super.key,
    required this.textBefore,
    required this.highlightedText,
    required this.textAfter,
    required this.underlineSvgAssetPath,
    this.style,
    this.highlightStyle,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle =
        style ??
        const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        );

    final orangeStyle =
        highlightStyle ??
        defaultStyle.copyWith(
          color: AppColors.primaryText,
          fontFamily: 'Geometry',
          fontSize: 30,
        );

    // Tambahkan spasi kalau belum ada
    final fixedTextBefore = textBefore.endsWith(' ')
        ? textBefore
        : '$textBefore ';

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: defaultStyle,
        children: [
          TextSpan(
            text: fixedTextBefore,
            style: TextStyle(fontFamily: 'Geometry', fontSize: 30),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Text(highlightedText, style: orangeStyle),
                Positioned(
                  bottom: -8, // sesuaikan sesuai desain
                  left: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    underlineSvgAssetPath,
                    height: 10,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          TextSpan(text: textAfter),
        ],
      ),
    );
  }
}
