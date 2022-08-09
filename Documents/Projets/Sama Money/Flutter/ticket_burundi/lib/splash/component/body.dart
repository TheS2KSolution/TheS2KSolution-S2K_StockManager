import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticket_burundi/utilities/constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: SvgPicture.asset(
            "images/Logo_fond_blanc.svg",
            width: 220,
          ),
        ),
        const SizedBox(
          height: 80,
        ),
        const SpinKitCircle(
          color: kPrimaryColor,
        ),
      ],
    );
  }
}
