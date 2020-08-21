import 'package:flutter/material.dart';
import 'package:hackathon/core/widgets/atoms/ui_text.dart';

class UiButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color fillColor, borderColor, textColor;

  UiButton(
      {this.text,
      this.onTap,
      this.fillColor = Colors.white,
      this.borderColor = Colors.transparent,
      this.textColor = Colors.white});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        elevation: 0,
        child: UiText(
          '$text',
          color: textColor,
        ),
        color: fillColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: borderColor, width: 1)),
        onPressed: onTap);
  }
}
