import 'dart:ui';

import 'package:flutter/material.dart';

class FlairBorder extends OutlinedBorder {
  static const double maxAmplitude = 90;
  static const minAmplitude = -maxAmplitude;

  static const maxPhase = maxAmplitude;
  static const minPhase = minAmplitude;

  final double phase;
  final double amplitude;

  const FlairBorder({
    super.side,
    this.phase = 0,
    this.amplitude = maxAmplitude,
  });

// ===========================================================================
  // Paths: getInnerPath y getOuterPath definen la forma, tanto externa como interna (sin borde)

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(
      _ajustarRect(rect).deflate(side.strokeInset),
    );
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(
      _ajustarRect(rect),
    );
  }

  Path _getPath(Rect rect) {
    if (amplitude == 0) {
      // Amplitud = 0 => cuadrado
      return Path()..addRect(rect);
    }

    final circlesPath = Path();
    const circleDiameter = maxAmplitude;
    final circlesHorizontal = (rect.width / circleDiameter) + 2;
    final circlesVertical = (rect.height / circleDiameter) + 2;

    for (var i = -1; i < circlesHorizontal; i++) {
      final translation = i * circleDiameter + phase;
      circlesPath
        ..addOval(Rect.fromCenter(
            center: rect.topLeft.translate(translation, 0),
            width: amplitude,
            height: amplitude))
        ..addOval(Rect.fromCenter(
            center: rect.bottomLeft.translate(translation, 0),
            width: amplitude,
            height: amplitude));
    }

    for (var i = -1; i < circlesVertical; i++) {
      final translation = i * circleDiameter + phase;
      circlesPath
        ..addOval(Rect.fromCenter(
            center: rect.topRight.translate(0, translation),
            width: amplitude,
            height: amplitude))
        ..addOval(Rect.fromCenter(
            center: rect.topLeft.translate(0, translation),
            width: amplitude,
            height: amplitude));
    }

    return Path.combine(PathOperation.xor, Path()..addRect(rect), circlesPath);

/*
    double increment = 100;

    final path = Path()..moveTo(rect.topLeft.dx, rect.topLeft.dy);
    bool positive = true;
    const magicNumber = 10;
    // arriba
    int pasos = (rect.width / increment).round();
    double acc = rect.topLeft.dx;
    for (var i = 1; i <= pasos; i++) {
      acc += increment;
      if (acc >= rect.topRight.dx) {
        path.lineTo(rect.topRight.dx, rect.topRight.dy);
      } else {
        for (var j = 0; j < 30; j++) {
          path.relativeLineTo(increment / 30, sin(j * (pi / 2)) * amplitude);
        }
      }
    }

    // derecha
    pasos = (rect.height / increment).round();
    acc = rect.topRight.dy;
    for (var i = 1; i <= pasos; i++) {
      acc += increment;
      if (acc >= rect.bottomRight.dy) {
        final adjust = rect.bottomRight.dy - acc;
        path.lineTo(rect.bottomRight.dx + (adjust * amplitude / magicNumber),
            rect.bottomRight.dy);
      } else {
        path.relativeLineTo(positive ? amplitude : -amplitude, increment);
      }
      positive = !positive;
    }

    // abajo
    pasos = (rect.width / increment).round();
    acc = rect.bottomRight.dx;
    for (var i = 1; i <= pasos; i++) {
      acc -= increment;
      if (acc <= rect.bottomLeft.dx) {
        final adjust = rect.bottomLeft.dx - acc;
        path.lineTo(rect.bottomLeft.dx,
            rect.bottomLeft.dy - (adjust * amplitude / magicNumber));
      } else {
        path.relativeLineTo(-increment, positive ? amplitude : -amplitude);
      }
      positive = !positive;
    }

    // izquierda
    pasos = (rect.height / increment).round();
    acc = rect.bottomLeft.dy;
    for (var i = 1; i <= pasos; i++) {
      acc -= increment;
      if (acc <= rect.topLeft.dy) {
        path.lineTo(rect.topLeft.dx, rect.topLeft.dy);
      } else {
        path.relativeLineTo(positive ? amplitude : -amplitude, -increment);
      }
      positive = !positive;
    }

    return path;
    */
  }

  /// Se asegura que el rect sea un cuadrado, o lo crea basandose en el lado más corto.
  Rect _ajustarRect(Rect rect) {
    return rect;
  }

// ===========================================================================

  // Paint: paint y paintInterior se ocupan de pintar la forma en un canvas, dibujando los bordes y el contenido respectivamente
  // podrían estar optimizados usando las apis de canvas (por ejemplo usando drawCircle en lugar de drawPath y pasandole el path de un circulo), pero no es nuestro caso

  @override
  bool get preferPaintInterior => true;

  @override
  void paintInterior(Canvas canvas, Rect rect, Paint paint,
      {TextDirection? textDirection}) {
    canvas.drawPath(getInnerPath(rect), paint);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    canvas.drawPath(getOuterPath(rect), side.toPaint());
  }

// ===========================================================================
// copyWith y scale son parte de la interfaz requerida por OutlinedShape. Son los ultimos override requeridos

  @override
  FlairBorder copyWith({BorderSide? side, double? amplitude, double? phase}) {
    return FlairBorder(
      side: side ?? this.side,
      amplitude: amplitude ?? this.amplitude,
      phase: phase ?? this.phase,
    );
  }

  @override
  ShapeBorder scale(double t) =>
      FlairBorder(side: side.scale(t), amplitude: amplitude, phase: phase);

// ===========================================================================
  // Opcionalmente, podemos definir la interpolación, para permitir transiciones de forma.

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is FlairBorder) {
      return FlairBorder(
        side: BorderSide.lerp(a.side, side, t),
        amplitude: lerpDouble(a.amplitude, amplitude, t)!,
        phase: lerpDouble(a.phase, phase, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is FlairBorder) {
      return FlairBorder(
        side: BorderSide.lerp(side, b.side, t),
        amplitude: lerpDouble(amplitude, b.amplitude, t)!,
        phase: lerpDouble(phase, b.phase, t)!,
      );
    }
    return super.lerpTo(b, t);
  }
}
