import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticket_burundi/state-page/component/body.dart';
import 'package:ticket_burundi/utilities/constants.dart';

class StatePAgeScreen extends StatefulWidget {
  static String routeName = "state";
  const StatePAgeScreen({Key? key}) : super(key: key);

  @override
  State<StatePAgeScreen> createState() => _StatePAgeScreenState();
}

class _StatePAgeScreenState extends State<StatePAgeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(gradient: kPrimaryGradientColor),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 40),
                  child: SvgPicture.asset(
                    "images/Logo_fond_bleu.svg",
                    width: 220,
                  ),
                ),
                const Body(),
              ],
            ),
          )),
    ));
  }
}
