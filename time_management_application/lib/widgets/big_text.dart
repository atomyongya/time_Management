import "package:flutter/material.dart";

class BigTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;

  const BigTextWidget({
    Key? key,
    required this.text,
    this.fontSize = 16.0,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: textColor,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
  