import 'package:flutter/material.dart';

class Stars extends StatelessWidget {
  final Animation<double> animation;
  const Stars({
    super.key,
    required this.animation,
  });

  final List<Alignment> _alignEstrellas = const [
    Alignment(-0.1, -0.6),
    Alignment(0.6, -0.1),
    Alignment(-0.2, 0.6),
  ];

  Tween<Offset> get positionTween => Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(0.2, -2),
      );

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: positionTween.animate(animation),
      child: Align(
        alignment: Alignment.centerRight,
        child: AspectRatio(
          aspectRatio: 1,
          child: Stack(
            children: _alignEstrellas.map(
              (alignment) {
                return Align(
                  alignment: alignment,
                  child: const _Star(),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}

class _Star extends StatelessWidget {
  const _Star();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.square(
      dimension: 6,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          shape: StarBorder(),
          color: Colors.white,
        ),
      ),
    );
  }
}
