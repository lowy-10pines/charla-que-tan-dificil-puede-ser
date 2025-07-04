import 'package:fancy_switch/painting/moon_border.dart';
import 'package:flutter/material.dart';

class Knob extends StatelessWidget {
  final Animation<double> animation;
  const Knob({
    super.key,
    required this.animation,
  });

  DecorationTween get decorationsTween => DecorationTween(
        begin: ShapeDecoration(
          color: Colors.yellow.shade50,
          shape: const MoonBorder(),
          shadows: const <BoxShadow>[
            BoxShadow(color: Colors.grey, blurRadius: 10.0, spreadRadius: 3.0),
          ],
        ),
        end: ShapeDecoration(
          color: Colors.yellow.shade400,
          shape: const CircleBorder(),
          shadows: const <BoxShadow>[
            BoxShadow(color: Colors.orange, blurRadius: 5.0, spreadRadius: 1.0),
          ],
        ),
      );

  AlignmentTween get alignmentTween => AlignmentTween(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: AlignTransition(
        alignment: alignmentTween.animate(animation),
        child: DecoratedBoxTransition(
          decoration: decorationsTween.animate(animation),
          child: const AspectRatio(aspectRatio: 1),
        ),
      ),
    );
  }
}
