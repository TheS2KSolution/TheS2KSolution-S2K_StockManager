import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticket_burundi/home/component/body.dart';
import 'package:ticket_burundi/utilities/constants.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(gradient: kPrimaryGradientColor),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 80.0, bottom: 80),
                  child: SvgPicture.asset(
                    "images/Logo_fond_bleu.svg",
                    width: 220,
                  ),
                ),
                Body(),
              ],
            )),
      ),
    );
  }
}
