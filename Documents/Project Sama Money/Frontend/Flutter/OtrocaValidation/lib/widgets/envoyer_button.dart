import 'package:flutter/material.dart';

class EnvoyerButton extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const EnvoyerButton({this.colour, this.title, @required this.onPressed});

  final Color? colour;
  final String? title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: TextButton(
        //style: const TextStyle(color: Colors.transparent),
        child: Container(
          height: 50,
          width: _width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(colors: [
                Color(0xFF01224b),
                Color(0xFF022e64),
                Color(0xFF023a7e),
              ])),
          child: Center(
            child: Text(
              title!,
              style: const TextStyle(
                  fontSize: 20,
                  letterSpacing: 1.5,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
