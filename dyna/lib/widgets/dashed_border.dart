import 'package:flutter/material.dart';

/// Draws a dashed rounded border around its child.
/// Flutter does not have a dashed border ready to use, so we paint it.
class DashedBorder extends StatelessWidget {
  final Widget child;
  final Color color;
  final double radius;

  const DashedBorder({
    super.key,
    required this.child,
    required this.color,
    this.radius = 14,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(color: color, radius: radius),
      child: child,
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;

  static const double _dashWidth = 8;
  static const double _dashSpace = 5;

  _DashedBorderPainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // A rounded rectangle path around the whole widget.
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)),
      );

    // Walk along the path and draw one small piece (dash) at a time.
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + _dashWidth),
          paint,
        );
        distance += _dashWidth + _dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.radius != radius;
  }
}
