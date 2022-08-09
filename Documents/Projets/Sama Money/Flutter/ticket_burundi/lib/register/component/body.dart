import 'dart:async';
import 'dart:io' show Platform;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_information/device_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_burundi/home/home_screen.dart';
import 'package:ticket_burundi/models/user.dart';
import 'package:ticket_burundi/models/user_save_result.dart';
import 'package:ticket_burundi/services/validation_service.dart';
import 'package:ticket_burundi/state-page/state_page_screen.dart';
import 'package:ticket_burundi/utilities/constants.dart';
import 'package:ticket_burundi/utilities/themes.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();

  bool? loading;
  final serviceLocator = GetIt.instance;
  String? deviceImei;

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  getAppPermissions() async {
    if (await Permission.phone.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAppPermissions();
    initPlatformState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if ((_connectionStatus == ConnectivityResult.mobile ||
        _connectionStatus == ConnectivityResult.wifi)) {
      return Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: _buildNomFormField(),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: _buildPrenomFormField(),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60.0, right: 60),
              child: ElevatedButton(
                  style: authButtonStyle(),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });

                      ValidationService validationService =
                          serviceLocator.get<ValidationService>();
                      var saveResult = validationService.userRegistration(User(
                          imei: deviceImei,
                          nom: _nomController.text,
                          prenom: _prenomController.text));

                      saveResult.then((UserSaveResult? res) async {
                        if (res != null) {
                          if (res.status == 1) {
                            // Obtain shared preferences.
                            final prefs = await SharedPreferences.getInstance();

                            // Save an boolean value to 'repeat' key.
                            await prefs.setBool('registered', true);
                            Navigator.of(context).pushReplacementNamed(
                                StatePAgeScreen.routeName);

                            setState(() {
                              loading = false;
                            });
                          } else if (res.status == 0) {
                            ValidationService validationService =
                                serviceLocator.get<ValidationService>();
                            var saveResult = validationService
                                .userRegistringVerification(deviceImei!);

                            saveResult.then((UserSaveResult? res) async {
                              if (res!.status == 1) {
                                // Obtain shared preferences.
                                final prefs =
                                    await SharedPreferences.getInstance();

                                // Save an boolean value to 'repeat' key.
                                await prefs.setBool('registered', true);

                                AwesomeDialog(
                                        context: context,
                                        animType: AnimType.SCALE,
                                        dialogType: DialogType.WARNING,
                                        body: Center(
                                          child: Text(
                                            res.msg!,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: kPrimaryColor),
                                          ),
                                        ),
                                        btnOkOnPress: () {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  HomeScreen.routeName);
                                        },
                                        btnOkColor: kPrimaryColor,
                                        btnOkText: "Aller à l'accueil")
                                    .show();
                              } else if (res.status == 0) {
                                Navigator.of(context).pushReplacementNamed(
                                    StatePAgeScreen.routeName);
                              }
                            });
                            setState(() {
                              loading = false;
                            });
                          }
                        }
                      });
                    }
                  },
                  child: !(loading != null && loading == true)
                      ? const Text(
                          "Valider",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 22),
                        )
                      : const SpinKitCircle(
                          color: Colors.white,
                        )),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Column(
          children: const [
            Icon(
              Icons.wifi_off,
              size: 100,
              color: Colors.white,
            ),
            Text(
              "Rassurez-vous d'avoir une connexion internet.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white),
            )
          ],
        ),
      );
    }
    ;
  }

  Widget _buildPrenomFormField() => TextFormField(
        controller: _prenomController,
        decoration: kTextFieldDecoration.copyWith(
            hintText: "Prénom", prefixIcon: Icon(Icons.man)),
        textAlign: TextAlign.start,
        autofocus: false,
        enabled: true,
        maxLines: 1,
        keyboardType: TextInputType.text,
        onChanged: (String value) {},
        textInputAction: TextInputAction.done,
        style: kTextFieldStyle,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Champ obligatoire';
          }
          return null;
        },
      );

  Widget _buildNomFormField() => TextFormField(
        controller: _nomController,
        decoration: kTextFieldDecoration.copyWith(
            hintText: "Nom", prefixIcon: Icon(Icons.man)),
        textAlign: TextAlign.start,
        autofocus: false,
        enabled: true,
        maxLines: 1,
        keyboardType: TextInputType.text,
        onChanged: (String value) {},
        textInputAction: TextInputAction.done,
        style: kTextFieldStyle,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Champ obligatoire';
          }
          return null;
        },
      );

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
      print("=====================IMEI START======================");
      print(deviceImei);
      print("=====================IMEI END======================");
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status');
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }
}
