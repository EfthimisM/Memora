import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUnderlinedText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight fontWeight;
  final Color color;
  final Color underlineColor;
  final double underlineThickness;
  final TextLeadingDistribution leadingDistribution;
  final String fontFamily;
  final bool isTablet;

  const AppUnderlinedText({
    super.key,
    required this.text,
    required this.size,
    this.fontWeight = FontWeight.normal,
    required this.color,
    this.underlineColor = Colors.white,
    this.underlineThickness = 1.5,
    this.leadingDistribution = TextLeadingDistribution.even,
    this.fontFamily = "Inter",
    this.isTablet = true
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: isTablet?size: size/2,
        color: color,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        decoration: TextDecoration.underline,
        decorationColor: underlineColor,
        decorationThickness: underlineThickness,
        leadingDistribution: leadingDistribution,
      ),
    );
  }
}