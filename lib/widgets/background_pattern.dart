import 'dart:math';
import 'package:flutter/material.dart';

class BackgroundPattern extends StatelessWidget {
  final Widget child;

  const BackgroundPattern({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFF9E1),
      child: Stack(
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: CirclePatternPainter(),
          ),
          child,
        ],
      ),
    );
  }
}

class CirclePatternPainter extends CustomPainter {
  final List<Color> colors = [
    const Color(0xFFD1FAE5),
    const Color(0xFFE0F2FE),
    const Color(0xFFF3E5F5),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(42);
    
    for (int i = 0; i < 30; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = 20 + random.nextDouble() * 60;
      final color = colors[random.nextInt(colors.length)];
      
      final paint = Paint()
        ..color = color.withOpacity(0.3)
        ..style = PaintingStyle.fill;
      
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
