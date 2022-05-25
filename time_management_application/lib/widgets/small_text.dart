import "package:flutter/material.dart";

class SmallTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color fontColor;

  const SmallTextWidget({
    Key? key,
    required this.text,
    this.fontSize = 16,
    this.fontColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: fontColor,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
