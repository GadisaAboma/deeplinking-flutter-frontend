import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final Color textColor;
  final double textFontSize;
  final FontWeight fontWeight;
  final String labelText;
  final TextAlign align;

  const HeaderText({
    this.textColor = Colors.black,
    this.textFontSize = 20,
    this.fontWeight = FontWeight.bold,
    required this.labelText,
    this.align = TextAlign.center,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      labelText,
      softWrap: true,
      overflow: TextOverflow.visible,
      textAlign: align,
      style: TextStyle(
          fontSize: textFontSize,
          color: textColor,
          fontWeight: fontWeight,
          fontFamily: "Poppins"),
    );
  }
}
