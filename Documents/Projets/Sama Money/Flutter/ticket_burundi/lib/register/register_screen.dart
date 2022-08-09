import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticket_burundi/register/component/body.dart';
import 'package:ticket_burundi/utilities/constants.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = "register";
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
