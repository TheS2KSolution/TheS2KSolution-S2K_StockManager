import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_information/device_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ticket_burundi/models/ticket.dart';
import 'package:ticket_burundi/models/validation_result.dart';
import 'package:ticket_burundi/saisi-code/saisi_code_screen.dart';
import 'package:ticket_burundi/services/validation_service.dart';
import 'package:ticket_burundi/utilities/constants.dart';
import 'package:ticket_burundi/utilities/themes.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScanResult? scanResult;
  String? deviceImei;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  var _aspectTolerance = 0.00;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;
  String _imeiNo = "";
  ValidationResult? response;
  final serviceLocator = GetIt.instance;

  static final _possibleFormats = BarcodeFormat.qr;

  bool? loading;

  List<BarcodeFormat> selectedFormats = [_possibleFormats];

  getAppPermissions() async {
    if (await Permission.camera.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.

    }
    if (await Permission.phone.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.

    }
  }

  @override
  void initState() {
    super.initState();

    initConnectivity();
    getAppPermissions();
    initPlatformState();

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
    return (_connectionStatus == ConnectivityResult.mobile ||
            _connectionStatus == ConnectivityResult.wifi)
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: ElevatedButton.icon(
                    style: defaultButtonHomeStyle(),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(SaisiCodeScreen.routeName);
                    },
                    icon: SvgPicture.asset(
                      "images/icon_saisi.svg",
                      width: 40,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Saisir les informations",
                      style: kHomeButtonTextStyle,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 40),
                child: ElevatedButton.icon(
                    style: defaultButtonHomeStyle(),
                    onPressed: () {
                      _scan();
                    },
                    icon: SvgPicture.asset(
                      "images/icon_qr.svg",
                      width: 40,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Scanner le QR code",
                      style: kHomeButtonTextStyle,
                    )),
              ),
              const SizedBox(
                height: 50,
              ),
              if ((loading != null && loading == true))
                const SpinKitCircle(
                  color: Colors.white,
                  size: 70,
                )
            ],
          )
        : Center(
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

  Future<void> _scan() async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': "Annuler",
            'flash_on': "Flash On",
            'flash_off': "Flash Off",
          },
          restrictFormat: selectedFormats,
          useCamera: _selectedCamera,
          autoEnableFlash: _autoEnableFlash,
          android: AndroidOptions(
            aspectTolerance: _aspectTolerance,
            useAutoFocus: _useAutoFocus,
          ),
        ),
      );
      setState(() => scanResult = result);
      List<String> codeResult = scanResult!.rawContent.split(";");
      if (codeResult.length == 2) {
        setState(() {
          loading = true;
        });
        String phone = codeResult[0];
        String code = codeResult[1];
        ValidationService validationService =
            serviceLocator.get<ValidationService>();
        var validationResult = validationService.ticketValidation(
            Ticket(imei: deviceImei, phoneBenef: "257" + phone, code: code));

        validationResult.then((ValidationResult? res) {
          response = res;
          setState(() {
            loading = false;
          });
          if (response != null) {
            if (response!.status! == 1) {
              AwesomeDialog(
                      context: context,
                      animType: AnimType.SCALE,
                      dialogType: DialogType.SUCCES,
                      body: Column(
                        children: [
                          if (response!.type == "1")
                            Column(
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.ticket,
                                  size: 90,
                                  color: kPlatinumColor,
                                ),
                                Text(
                                  response!.typeNomFr!,
                                  style: const TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor),
                                ),
                              ],
                            ),
                          if (response!.type == "2")
                            Column(
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.ticket,
                                  size: 90,
                                  color: kGoldColor,
                                ),
                                Text(
                                  response!.typeNomFr!,
                                  style: const TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor),
                                ),
                              ],
                            ),
                          if (response!.type == "3")
                            Column(
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.ticket,
                                  size: 90,
                                  color: kSilverColor,
                                ),
                                Text(
                                  response!.typeNomFr!,
                                  style: const TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor),
                                ),
                              ],
                            ),
                          if (response!.type == "4")
                            Column(
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.ticket,
                                  size: 90,
                                  color: kBronzeColor,
                                ),
                                Text(
                                  response!.typeNomFr!,
                                  style: const TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor),
                                ),
                              ],
                            ),
                          if (response!.type == "5")
                            Column(
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.ticket,
                                  size: 90,
                                  color: kVvipColor,
                                ),
                                Text(
                                  response!.typeNomFr!,
                                  style: const TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor),
                                ),
                              ],
                            ),
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Text(
                              response!.msg!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                          ),
                        ],
                      ),
                      btnOkOnPress: () {},
                      btnOkColor: kPrimaryColor,
                      btnOkText: "Fermer")
                  .show();
            } else if (response!.status == 0) {
              AwesomeDialog(
                      context: context,
                      animType: AnimType.SCALE,
                      dialogType: DialogType.ERROR,
                      body: Column(
                        children: [
                          if (response!.type == "1")
                            Column(
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.ticket,
                                  size: 90,
                                  color: kPlatinumColor,
                                ),
                                Text(
                                  response!.typeNomFr!,
                                  style: const TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor),
                                ),
                              ],
                            ),
                          if (response!.type == "2")
                            Column(
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.ticket,
                                  size: 90,
                                  color: kGoldColor,
                                ),
                                Text(
                                  response!.typeNomFr!,
                                  style: const TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor),
                                ),
                              ],
                            ),
                          if (response!.type == "3")
                            Column(
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.ticket,
                                  size: 90,
                                  color: kSilverColor,
                                ),
                                Text(
                                  response!.typeNomFr!,
                                  style: const TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor),
                                ),
                              ],
                            ),
                          if (response!.type == "4")
                            Column(
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.ticket,
                                  size: 90,
                                  color: kBronzeColor,
                                ),
                                Text(
                                  response!.typeNomFr!,
                                  style: const TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor),
                                ),
                              ],
                            ),
                          if (response!.type == "5")
                            Column(
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.ticket,
                                  size: 90,
                                  color: kVvipColor,
                                ),
                                Text(
                                  response!.typeNomFr!,
                                  style: const TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor),
                                ),
                              ],
                            ),
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Text(
                              response!.msg!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                          ),
                        ],
                      ),
                      btnOkOnPress: () {},
                      btnOkColor: kPrimaryColor,
                      btnOkText: "Fermer")
                  .show();
            }
          }
        });
      } else {
        AwesomeDialog(
                context: context,
                animType: AnimType.SCALE,
                dialogType: DialogType.WARNING,
                body: const Center(
                  child: Text(
                    "Le code que vous scannez n'est pas valable pour cet évènement.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                  ),
                ),
                btnOkOnPress: () {},
                btnOkColor: kPrimaryColor,
                btnOkText: "Fermer")
            .show();
      }
    } on PlatformException catch (e) {
      setState(() {
        scanResult = ScanResult(
          type: ResultType.Error,
          format: BarcodeFormat.unknown,
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? 'The user did not grant the camera permission!'
              : 'Unknown error: $e',
        );
      });
    }
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
    });
  }
}
