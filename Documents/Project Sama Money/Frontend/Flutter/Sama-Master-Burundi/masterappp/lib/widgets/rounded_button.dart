import 'package:flutter/material.dart';
class RoundedButton extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const RoundedButton({this.colour, this.title, @required this.onPressed});

  final Color? colour;
  final String? title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SizedBox(
        width: _width,
        child: Material(
          elevation: 5.0,
          color: colour,
          borderRadius: BorderRadius.circular(10.0),
          child: MaterialButton(
            onPressed: onPressed!,
            // minWidth: 200.0,
            height: 42.0,
            child: Text(
              title!,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
