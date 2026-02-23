import 'package:flutter/cupertino.dart';

class AppText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight fontWeight;
  final Color color;
  final String fontFamily;
  final bool isTablet;

  const AppText({
    super.key,
    required this.text,
    required this.size,
    this.fontWeight = FontWeight.normal,
    required this.color,
    this.fontFamily = "Inter",
    this.isTablet = true

  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: isTablet? size : size/2,
        color: color,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
      ),
    );
  }
}
