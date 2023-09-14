import 'package:fancy_switch/widget/background.dart';
import 'package:flutter/material.dart';

class FancySwitch extends StatefulWidget {
  final bool value;
  final void Function(bool value) onChanged;

  const FancySwitch({super.key, required this.value, required this.onChanged});

  @override
  State<FancySwitch> createState() => _FancySwitchState();
}

class _FancySwitchState extends State<FancySwitch>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  Animation<double> get curvedAnimation => CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      );

  @override
  void initState() {
    if (widget.value) {
      _controller.forward(from: 1);
    } else {
      _controller.reverse(from: 0);
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FancySwitch oldWidget) {
    if (widget.value) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 30,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: GestureDetector(
          onTap: () {
            widget.onChanged.call(!widget.value);
          },
          child: Background(
            animation: curvedAnimation,
            child: Stack(children: []),
          ),
        ),
      ),
    );
  }
}
