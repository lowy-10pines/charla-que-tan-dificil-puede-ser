import 'package:flutter/material.dart';

class Cloud extends StatelessWidget {
  final Animation<double> animation;
  const Cloud({
    super.key,
    required this.animation,
  });

  Tween<Offset> get positionTween => Tween<Offset>(
        begin: const Offset(-1, 2),
        end: const Offset(-0.3, 0),
      );

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: positionTween.animate(animation),
      child: const Padding(
        padding: EdgeInsets.only(top: 8),
        child: AspectRatio(
          aspectRatio: 1.2,
          child: CustomPaint(painter: CloudPainter()),
        ),
      ),
    );
  }
}

class CloudPainter extends CustomPainter {
  const CloudPainter() : super();

  @override
  void paint(Canvas canvas, Size size) {
    final dx = size.width / 6;
    final dy = size.height / 3;

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Large circle
    canvas.drawCircle(Offset(1.5 * dx, 1.5 * dy), 1.5 * dy, paint);

    // Medium circle
    canvas.drawCircle(Offset(5 * dx, 2 * dy), dy, paint);

    // Small circle
    canvas.drawCircle(Offset(7 * dx, 2.5 * dy), 0.5 * dy, paint);

    // Fillers
    canvas.drawRect(
        Rect.fromPoints(Offset(1.5 * dx, 2.5 * dy), Offset(7 * dx, 3 * dy)),
        paint);
    canvas.drawRect(
        Rect.fromPoints(Offset(1.5 * dx, 1.5 * dy), Offset(5 * dx, 3 * dy)),
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
