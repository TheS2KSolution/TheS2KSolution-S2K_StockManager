import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticket_burundi/saisi-code/component/body.dart';
import 'package:ticket_burundi/utilities/constants.dart';

class SaisiCodeScreen extends StatefulWidget {
  static String routeName = "saisi-code";
  const SaisiCodeScreen({Key? key}) : super(key: key);

  @override
  State<SaisiCodeScreen> createState() => _SaisiCodeScreenState();
}

class _SaisiCodeScreenState extends State<SaisiCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Retour à l'accueil"),
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
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
