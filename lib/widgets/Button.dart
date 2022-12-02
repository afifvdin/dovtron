import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final Color color;
  final Widget child;
  const Button({super.key, required this.color, required this.child});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
            blurRadius: 1,
            color: Colors.black38,
            spreadRadius: 0,
            offset: Offset(0, 1))
      ], color: widget.color, borderRadius: BorderRadius.circular(8)),
      height: 44,
      width: double.infinity,
      child: Center(child: widget.child),
    );
  }
}
