import 'package:flutter/material.dart';


class CircleProgressPainter extends CustomPainter {
  final double progress;
  final double borderWidth;

  CircleProgressPainter({required this.progress, required this.borderWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - borderWidth) / 2;

    final borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, borderPaint);

    final progressPaint = Paint()
      ..color = Color(0xFFCC8800)
      ..strokeWidth = borderWidth + 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final startAngle = 0.5 * 3.14159;
    final sweepAngle = progress *2 * 3.14159;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}