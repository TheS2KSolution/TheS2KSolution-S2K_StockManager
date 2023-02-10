import 'package:flutter/material.dart';
import 'package:masterappp/constants/constants.dart';

class EnvoyerButton extends StatelessWidget {
  EnvoyerButton({this.colour, this.title, required this.onPressed});

  final Color? colour;
  final String? title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0),
      child: Container(
        width: _width,
        child: TextButton(
          style: TextButton.styleFrom(primary: Colors.transparent),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kSamaRougeDegradeColor
                /* gradient: LinearGradient(colors: [
                  Color(0xFF01224b),
                  Color(0xFF022e64),
                  Color(0xFF023a7e),
                ])*/
                ),
            child: Center(
              child: Text(
                title!,
                style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
