import 'package:flutter/material.dart';

final darkPinero = ThemeData.dark(useMaterial3: true).copyWith(
    colorScheme: const ColorScheme.dark(
  primary: Color.fromARGB(255, 164, 0, 255),
  secondary: Color.fromARGB(255, 251, 40, 104),
));

final lightPinero = ThemeData.light(useMaterial3: true).copyWith(
    colorScheme: const ColorScheme.light(
  primary: Color.fromARGB(255, 113, 255, 92),
  secondary: Color.fromARGB(255, 57, 255, 233),
));
