import 'package:clothing_store_app/utils/themes.dart';
import 'package:flutter/material.dart';

class CustomDiagonalLine extends CustomPainter { 
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.greyBackgroundColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(size.width, 2), Offset(3, size.height), paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}