import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:masterappp/constants/constants.dart';
import 'package:masterappp/controllers/splashscreen_controller.dart';


class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final controllerRestApi = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }

  initScreen(BuildContext context) {
    return Container(
      decoration: kBackGroundDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                "images/fond_rouge.svg",
                height: 50.0,
              ),
              const SizedBox(
                height: 100,
              ),
              const SpinKitFadingCircle(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
