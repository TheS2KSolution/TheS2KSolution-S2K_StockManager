import 'package:flutter/material.dart';

class CustomHeaderText extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;

  CustomHeaderText({required this.text, this.size, this.color, this.weight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          fontFamily: 'Avenir Next LTPro',
          fontSize: size ?? 22,
          fontWeight: weight ?? FontWeight.normal,
          color: color ?? Colors.white70),
      textAlign: TextAlign.center,
    );
  }
}
