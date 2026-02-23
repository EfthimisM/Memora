import 'package:flutter/cupertino.dart';

class InstructionText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final String fontFamily;
  final bool isTablet;

  const InstructionText({
    super.key,
    required this.text,
    required this.size,
    this.fontWeight = FontWeight.normal,
    required this.color,
    this.textAlign = TextAlign.center,
    this.fontFamily = "Inter",
    this.isTablet = true
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize:isTablet? size : size/2,
        color: color,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
      ),
    );
  }
}