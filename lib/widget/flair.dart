import 'package:fancy_switch/painting/flair_border.dart';
import 'package:flutter/material.dart';

class Flair extends StatefulWidget {
  final Widget child;
  const Flair({super.key, required this.child});

  @override
  State<Flair> createState() => _FlairState();
}

class _FlairState extends State<Flair> with TickerProviderStateMixin {
  late final AnimationController _controllerReverse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  )..repeat(reverse: true);

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  )..repeat();

  DecorationTween decorationTween(ThemeData theme) => DecorationTween(
        begin: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.secondary,
            theme.colorScheme.surface,
          ],
        )),
        end: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.colorScheme.surface,
            theme.colorScheme.primary,
            theme.colorScheme.secondary,
          ],
        )),
      );

  DecorationTween shapeTween(ThemeData theme) => DecorationTween(
        begin: ShapeDecoration(
          shape: const FlairBorder(
              amplitude: FlairBorder.maxAmplitude, phase: FlairBorder.minPhase),
          color: theme.colorScheme.surface,
        ),
        end: ShapeDecoration(
          shape: const FlairBorder(
              amplitude: FlairBorder.minAmplitude, phase: FlairBorder.maxPhase),
          color: theme.colorScheme.surface,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DecoratedBoxTransition(
          decoration:
              decorationTween(Theme.of(context)).animate(_controllerReverse),
          child: Expanded(
            child: Container(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 62, vertical: 68),
          child: DecoratedBoxTransition(
              decoration: shapeTween(Theme.of(context)).animate(_controller),
              child: widget.child),
        ),
      ],
    );
  }
}
