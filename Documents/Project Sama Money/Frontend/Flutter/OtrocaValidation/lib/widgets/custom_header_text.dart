import 'package:flutter/material.dart';

class CustomHeaderText extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;

  const CustomHeaderText(
      {Key? key, @required this.text, this.size, this.color, this.weight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          fontFamily: 'Avenir Next LTPro',
          fontSize: size ?? 26,
          fontWeight: weight ?? FontWeight.normal,
          color: color ?? Colors.black54),
      textAlign: TextAlign.center,
    );
  }
}
