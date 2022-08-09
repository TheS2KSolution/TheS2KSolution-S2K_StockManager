import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:device_information/device_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_burundi/home/home_screen.dart';
import 'package:ticket_burundi/main.dart';
import 'package:ticket_burundi/models/user_save_result.dart';
import 'package:ticket_burundi/register/register_screen.dart';
import 'package:ticket_burundi/services/validation_service.dart';
import 'package:ticket_burundi/splash/component/body.dart';
import 'package:ticket_burundi/state-page/state_page_screen.dart';
import 'package:ticket_burundi/utilities/constants.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "splash";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? deviceImei;

  Future redirectToHome() async {
    await Future.delayed(const Duration(seconds: 5));
  }

  // Obtain shared preferences.
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late bool _isRegister = false;

  Future<void> _getRegisteredSharedInstance() async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _isRegister = prefs.getBool('registered') ?? false;
    });
  }

  getAppPermissions() async {
    if (await Permission.phone.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.

    }
  }

  @override
  void initState() {
    super.initState();
    _getRegisteredSharedInstance();
    getAppPermissions();
    initPlatformState();
    redirectToHome().then((value) {
      if (!_isRegister) {
        Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
      } else if (_isRegister) {
        ValidationService validationService =
            serviceLocator.get<ValidationService>();
        var saveResult =
            validationService.userRegistringVerification(deviceImei!);

        saveResult.then((UserSaveResult? res) async {
          print(
              "=====================================VERIFY START======================================");
          print(res!.toJson());
          print(
              "=====================================VERIFY END=======================================");

          if (res.status == 1) {
            print(
                "==================================VERIFY STATUS START====================================");
            print("STATUS 1");
            print(
                "==================================VERIFY STATUS END======================================");
            // Obtain shared preferences.
            final prefs = await SharedPreferences.getInstance();

            // Save an boolean value to 'repeat' key.
            await prefs.setBool('registered', true);
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          } else if (res.status == 0) {
            print(
                "==================================VERIFY STATUS START====================================");
            print("STATUS 0");
            print(
                "==================================VERIFY STATUS END======================================");

            Navigator.of(context)
                .pushReplacementNamed(StatePAgeScreen.routeName);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }

  Future<void> initPlatformState() async {
    late String imeiNo = '';
    // Platform messages may fail,
    // so we use a try/catch PlatformException.
    try {
      imeiNo = await DeviceInformation.deviceIMEINumber;
    } on PlatformException catch (e) {}

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      deviceImei = imeiNo;
      print("=====================IMEI SPLASH START======================");
      print(deviceImei);
      print("=====================IMEI SPLASH END======================");
    });
  }
}
