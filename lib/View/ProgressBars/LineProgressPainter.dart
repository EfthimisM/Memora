import 'package:flutter/material.dart';

class LineProgressPainter extends CustomPainter {
  final double progress;
  final double borderWidth;
  final double lineLength;

  LineProgressPainter({
    required this.progress,
    required this.borderWidth,
    required this.lineLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final startPoint = Offset(0, size.height / 2);
    final endPoint = Offset(lineLength, size.height / 2);

    final borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(startPoint, endPoint, borderPaint);

    final progressPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = borderWidth + 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressEndPoint = Offset(progress * lineLength, size.height / 2);
    canvas.drawLine(startPoint, progressEndPoint, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}