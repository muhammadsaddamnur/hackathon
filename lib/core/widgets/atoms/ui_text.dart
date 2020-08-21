import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum TextSize { small, medium, large }

class UiText extends StatelessWidget {
  final String text;
  final TextSize textSize;
  final Color color;
  final FontWeight fontWeight;
  final int maxLines;

  UiText(this.text,
      {this.textSize, this.color, this.fontWeight, this.maxLines});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: textSize == TextSize.small
            ? 12
            : textSize == TextSize.medium
                ? 15
                : textSize == TextSize.large ? 17 : null,
        color: color,
        fontWeight: fontWeight,
      ),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
