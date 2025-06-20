import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  const Background({super.key, required this.child, required this.animation});

  DecorationTween get backgroundAnimationTween => DecorationTween(
        begin: const BoxDecoration(color: Color(0xFF050357)),
        end: BoxDecoration(color: Colors.blue.shade300),
      );

  @override
  Widget build(BuildContext context) {
    return DecoratedBoxTransition(
      decoration: backgroundAnimationTween.animate(animation),
      child: child,
    );
  }
}
