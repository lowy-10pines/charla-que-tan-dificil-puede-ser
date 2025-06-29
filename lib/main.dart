import 'package:fancy_switch/fancy_switch.dart';
import 'package:fancy_switch/theme.dart';
import 'package:fancy_switch/widget/flair.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FancySwitchApp());
}

class FancySwitchApp extends StatefulWidget {
  const FancySwitchApp({super.key});

  @override
  State<FancySwitchApp> createState() => _FancySwitchAppState();
}

class _FancySwitchAppState extends State<FancySwitchApp> {
  bool value = true;

  void _setValue(bool newValue) {
    setState(() {
      value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fancy Switch demo',
      themeMode: value ? ThemeMode.light : ThemeMode.dark,
      darkTheme: darkPinero,
      theme: lightPinero,
      home: Scaffold(
        body: Flair(
          child: Center(
            child: Transform.scale(
              scale: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Switch.adaptive(value: value, onChanged: _setValue),
                  FancySwitch(value: value, onChanged: _setValue),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
