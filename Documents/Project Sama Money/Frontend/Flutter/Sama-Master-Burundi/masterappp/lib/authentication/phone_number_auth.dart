import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:device_information/device_information.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:masterappp/Services/services.dart';
import 'package:masterappp/config/config.dart';
import 'package:masterappp/constants/constants.dart';
import 'package:masterappp/constants/important_text_constant.dart';
import 'package:masterappp/controllers/country_list_controller.dart';
import 'package:masterappp/internet/internet_checker.dart';
import 'package:masterappp/models/countries.dart';
import 'package:masterappp/routes/route_constants.dart';
import 'package:masterappp/widgets/rounded_button.dart';
import 'package:masterappp/widgets/show_dialog_box.dart';
import 'package:permission_handler/permission_handler.dart';


class PhoneNumberAuth extends StatefulWidget {
  const PhoneNumberAuth({Key? key}) : super(key: key);

  @override
  State<PhoneNumberAuth> createState() => _PhoneNumberAuthState();
}

class _PhoneNumberAuthState extends State<PhoneNumberAuth> {
  final GlobalKey<FormState> _form1Key = GlobalKey();

  String password = "";
  String numero = "";

  final CountryListController countryListController =
      Get.put(CountryListController());

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  int selectedCountryIndex = 0;

  StreamController<List<Country>>? countriesStreamController;

  Stream<List<Country>>? countriesStream;

  Sink<List<Country>>? countriesSink;

  // final TextEditingController searchCountryController = TextEditingController();

  String _platformVersion = 'Unknown';
  String _imeiNo = "";
  String _modelName = "";
  String _manufacturerName = "";
  String _deviceName = "";
  String _productName = "";
  String _cpuType = "";
  String _manufacturer = "";
  String _hardware = "";
  var _apiLevel;

  Future<void> initPlatformState() async {
    String platformVersion;
    String imeiNo = '';
    String modelName = '';
    String manufacturer = '';
    String deviceName = '';
    String productName = '';
    String cpuType = '';
    String hardware = '';
    var apiLevel;

    try {
      platformVersion = await DeviceInformation.platformVersion;
      imeiNo = await DeviceInformation.deviceIMEINumber;
      modelName = await DeviceInformation.deviceModel;
      manufacturer = await DeviceInformation.deviceManufacturer;
      apiLevel = await DeviceInformation.apiLevel;
      deviceName = await DeviceInformation.deviceName;
      productName = await DeviceInformation.productName;
      cpuType = await DeviceInformation.cpuName;
      hardware = await DeviceInformation.hardware;
    } on PlatformException catch (e) {
      platformVersion = '${e.message}';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = "Running on :$platformVersion";
      _imeiNo = imeiNo;
      _modelName = modelName;
      _manufacturerName = manufacturer;
      _apiLevel = apiLevel;
      _deviceName = deviceName;
      _productName = productName;
      _cpuType = cpuType;
      _hardware = hardware;
    });
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  String _fcmToken = '';

  _register() {
    _firebaseMessaging.getToken().then((token) {
      setState(() {
        _fcmToken = token!;
        print(_fcmToken);
      });
    });
  }

  _saveUserResult(result) async {
    await AgentSamaWeb.userResulBox!
        .put(AgentSamaWeb.userResultHiveKey, result);
  }

  firstConnectionMaster() async {
    numero = phoneNumberController.text;
    password = passwordController.text;
    print("=============================");
    print("Connexion screen");
    print("=============================");
    Dio dio = Dio();
    String url = 'enregistrer/phone';
    // String url='V1/json/test';
    String finalPhone = numero.replaceAll(RegExp(r"\s\b|\b\s"), "");
    dio.options.headers['Content-type'] = 'application/json';
    dio.options.headers['Authorization'] = AgentSamaWeb.authorization;
    dio.options.headers['imei'] = AgentSamaWeb.authorization;
    Map<String, String> bodyJson = HashMap();
    bodyJson['phone'] = '257$finalPhone';
    bodyJson['loginpassword'] = '$password';
    bodyJson['fcm_token'] = '$_fcmToken';
    bodyJson['imei'] = '$_imeiNo';
    print(bodyJson);

    bool connectState = await InternetConnectivityCheck().isInternet();

    if (connectState) {
      String result = await Services.httpPostRequest(dio, url, bodyJson);
      print(result);

      if (result == "error") {
        print("=============================");
        print("ERROR");
        print("=============================");
        setState(() {
          _progressBarActive = false;
        });
      } else {
        print("=============================");
        print("DONE");
        print("=============================");
        var data = json.decode(result);
        var sta = data["status"];
        var msg = data["msg"];

        if (sta == 0) {
          print("=============================");
          print("DONE ERROR");
          print("=============================");
          setState(() {
            _progressBarActive = false;
          });

          CustomDialogBox().onErrorAlertDialog(context, msg);
        } else {
          print("=============================");
          print("DONE SUCCESS");
          print("=============================");
          setState(() {
            _progressBarActive = false;
          });
          _saveUserResult(result);

          Get.offAndToNamed(loginScreenRoute);
        }
      }
    } else {
      CustomDialogBox().noInternetSimpleshowDialog(
          context, "Pas d'Internet", "Vous n'êtes pas connecté à internet.");
    }
  }

  getDeviceInfo() async {
    if (await Permission.phone.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.

      try {
        initPlatformState();
      } catch (e) {
        print(e);
      }
    }
  }

  bool _progressBarActive = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _register();
    getDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBackGroundDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Obx(() {
          if (!countryListController.isCountryListLoaded.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return getBody();
          }
        }),
      ),
    );
  }

  Widget getBody() => SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40.0,
                  ),
                  SvgPicture.asset(
                    "images/fond_rouge.svg",
                    height: 50.0,
                  ),
                  Form(
                    key: _form1Key,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40.0,
                        ),
                        Container(
                          padding: kTextFieldContainerPadding,
                          decoration: kTextFieldContainerBoxDecoration,
                          child: TextFormField(
                            controller: phoneNumberController,
                            keyboardType: TextInputType.phone,
                            style: kTextFieldStyle,
                            onChanged: (value) {},
                            inputFormatters: const [],
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Veuillez renseigner votre numéro de téléphone.';
                              } else {
                                return null;
                              }
                            },
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Numéro de téléphone',
                              hintStyle: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.normal),
                              errorMaxLines: 1,
                              prefix: Text(
                                "  "
                                '${countryListController.countryList[selectedCountryIndex].dialCode}'
                                "  ",
                              ),
                              prefixStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: const Text(
                            'Sans l\'indicatif',
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Card(
                              shadowColor: Colors.black54,
                              color: Colors.grey[200],
                              child: Container(
                                height: 60,
                                alignment: Alignment.center,
                                child: TextFormField(
                                  controller: passwordController,
                                  keyboardType: TextInputType.number,
                                  obscureText: true,
                                  onChanged: (value) {},
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 10),
                                    hintText: "Mot de passe",
                                    hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.normal),
                                    errorMaxLines: 1,
                                  ),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Veuillez renseigner votre mot de passe.';
                                    } else if (value.length < 6) {
                                      return 'Mot de passe incorrect.';
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: const TextStyle(
                                      letterSpacing: 1.0,
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  RoundedButton(
                    colour: kSamaRougeDegradeColor,
                    title: "Envoyer",
                    onPressed: () async {
                      if (_form1Key.currentState!.validate()) {
                        setState(() {
                          _progressBarActive = true;
                        });

                        print("=======================================");
                        print(phoneNumberController.text);
                        print(passwordController.text);
                        print("=======================================");

                        bool connectState =
                            await InternetConnectionChecker().hasConnection;
                        if (connectState) {
                          print("=======================================");
                          print("CONNEXION STATE GOOD");
                          print("=======================================");

                          firstConnectionMaster();
                        } else {
                          setState(() {
                            _progressBarActive = false;
                          });
                          CustomDialogBox().noInternetSimpleshowDialog(
                              context,
                              "Pas d'Internet",
                              "Vous n'êtes pas connecté à internet.");
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
