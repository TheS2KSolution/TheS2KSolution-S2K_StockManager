import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:masterappp/Services/fingerprint_class.dart';
import 'package:masterappp/Services/services.dart';
import 'package:masterappp/config/config.dart';
import 'package:masterappp/constants/constants.dart';
import 'package:masterappp/constants/flutter_pattern.formatter.dart';
import 'package:masterappp/constants/important_text_constant.dart';
import 'package:masterappp/internet/internet_checker.dart';
import 'package:masterappp/routes/route_constants.dart';
import 'package:masterappp/widgets/custom_app_bar.dart';
import 'package:masterappp/widgets/custom_drawer.dart';
import 'package:masterappp/widgets/custom_header_text.dart';
import 'package:masterappp/widgets/envoyer_button.dart';
import 'package:masterappp/widgets/progress_dialog.dart';
import 'package:masterappp/widgets/show_dialog_box.dart';

class RetourUvScreen extends StatefulWidget {
  const RetourUvScreen({Key? key}) : super(key: key);

  @override
  _RetourUvScreenState createState() => _RetourUvScreenState();
}

class _RetourUvScreenState extends State<RetourUvScreen> {
  final _formKey = GlobalKey<FormState>();

  String? pass = '';
  String? login;
  String? iduser;
  String? imei;
  String? phone;
  String? montant = '';
  bool _progressBarActive = false;

  String password = '';

  final GlobalKey<FormState> formKeyAlert = GlobalKey();

  bool _isVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserInfo();
  }

  _getUserInfo() async {
    if (AgentSamaWeb.userResulBox!.isNotEmpty) {
      String rslt =
          await AgentSamaWeb.userResulBox!.get(AgentSamaWeb.userResultHiveKey);
      var tat = json.decode(rslt);

      setState(() {
        phone = tat['phone'];
        login = tat['login'];
        iduser = tat['iduser'];
        imei = tat['imei'];
      });

      if (AgentSamaWeb.identifiantBox!.isNotEmpty) {
        var identifiant = await AgentSamaWeb.identifiantBox!
            .get(AgentSamaWeb.identifiantHiveKey);
        print(identifiant);
        setState(() {
          pass = identifiant;
          // _isVisible = true;
        });
      }
    }
  }

  Widget _buildMontantRetourUV() => TextFormField(
      decoration: kTextFieldDecoration.copyWith(hintText: "Montant"),
      textAlign: TextAlign.start,
      autofocus: false,
      maxLines: 1,
      enabled: true,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        ThousandsFormatter()
      ],
      onChanged: (String value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
        setState(() {
          montant = value;
        });
      },
      onSaved: (String? value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
        setState(() {
          montant = value;
        });
      },
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Veuillez renseigner le montant.";
        } else
          return null;
      },
      textInputAction: TextInputAction.done,
      style: kTextFieldStyle);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBackGroundDecoration,
      child: Scaffold(
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        backgroundColor: Colors.transparent,
        body: _progressBarActive == true
            ? CustomCircularProgresssDialog()
            : getBody(),
      ),
    );
  }

  Widget getBody() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child:
            ListView(physics: const ClampingScrollPhysics(), children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          CustomHeaderText(
            text: "Retour d'UV à SAMA",
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                    padding: kTextFieldContainerPadding,
                    decoration: kTextFieldContainerBoxDecoration,
                    child: _buildMontantRetourUV()),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
          ),
          EnvoyerButton(
            title: "Envoyer",
            onPressed: _submitCommand,
          ),
          const SizedBox(
            height: 40.0,
          ),
        ]),
      );

  void _submitCommand() {
    //get state of our Form
    final form = _formKey.currentState;

    if (form!.validate()) {
      showCustomDialogWithImage(context, montant!);
    }
  }

  void showCustomDialogWithImage(BuildContext context, String montant) {
    Dialog dialogWithImage = Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 430.0,
        width: 300.0,
        child: Form(
          key: formKeyAlert,
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                      // color: kUbaRougeColor
                      color: Color(0xFFd61a0e)),
                  child: Container(
                    width: 300,
                    height: 60,
                    child: const Icon(
                      Icons.message,
                      color: Colors.white,
                      size: 35.0,
                    ),
                  )),
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                    color: Colors.white),
                child: Column(children: <Widget>[
                  Container(
                    height: 80.0,
                    width: 300.0,
                    padding: const EdgeInsets.only(
                        left: 15.0, top: 10.0, right: 15.0),
                    child: Text(
                      "Vous allez faire un retour de " +
                          montant +
                          " FBU à SAMA" +
                          ". Veuillez saisir votre mot de passe pour continuer.",
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                      width: 300,
                      padding: const EdgeInsets.only(
                          left: 15.0, top: 0.0, right: 15.0),
                      child: Container(
                        //height: 30,
                        padding: kTextFieldContainerPaddingPassword,
                        decoration: kTextFieldContainerBoxDecoration,
                        child: TextFormField(
                          decoration: kTextFieldDecorationPassword.copyWith(
                              hintText: "Entrez votre mot de passe "),
                          textAlign: TextAlign.start,
                          autofocus: false,
                          enabled: true,
                          maxLines: 1,
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Veuillez renseigner votre mot de passe.";
                            } else if (value.length < 4)
                              return "Mot de passe incorrect.";
                            else
                              return null;
                          },
                          textInputAction: TextInputAction.done,
                          onChanged: (String value) {
                            setState(() {
                              password = value;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              password = value!;
                            });
                          },
                          style: kTextFieldStylePassword,
                        ),
                      )),
                  Container(
                    width: 300.0,
                    padding: EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            child: const Center(
                              child: Text(
                                "Annuler",
                                style: TextStyle(
                                    // color: kUbaRougeColor,
                                    color: Color(0xFFd61a0e),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            final form3 = formKeyAlert.currentState;

                            if (form3!.validate()) {
                              setState(() {
                                _progressBarActive = true;
                              });
                              // Navigator.of(context).pop();
                              goToInternet();
                            }
                          },
                          style: TextButton.styleFrom(
                            primary: Colors.transparent,
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(colors: [
                                  Color(0xFF01224b),
                                  Color(0xFF01224b),
                                  Color(0xFF01224b)
                                ])),
                            child: const Center(
                              child: Text(
                                "Continuer",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: 300,
                    child: Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Divider(
                            height: 5.0,
                            thickness: 3.0,
                            color: Color(0xFF01224b),
                          ),
                        ),
                        const Center(
                          child: Text(
                            "Continuer avec l'empreinte digitale",
                            style: TextStyle(
                                color: Color(0xFF01224b), fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Get.back();

                            _authenticateUser();
                          },
                          icon: const Icon(
                            Icons.fingerprint,
                            size: 40,
                            color: Color(0xFF01224b),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    )),
                  ),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => dialogWithImage);
  }

  _authenticateUser() async {
    bool getState = await FingerPrint.authenticateUser();

    if (getState) {
      setState(() {
        _progressBarActive = true;
        password = pass!;
      });

      goToInternet();
      print("============================================");
      print("FINGERPRINT RETOUR UV WORKS");
      print("============================================");

      setState(() {
        _progressBarActive = false;
      });
    } else {
      print('Not Authorized');
    }
  }

  goToInternet() async {
    bool connectState = await InternetConnectivityCheck().isInternet();
    if (connectState) {
      _makePostRequest();
    } else {
      setState(() {
        _progressBarActive = false;
      });
      CustomDialogBox().noInternetSimpleshowDialog(
          context, "Pas d'Internet", "Vous n'êtes pas connecté à internet.");
    }
  }

  _makePostRequest() async {
    String url = 'retour/uv/sama';
    Dio dio = Dio();
    dio.options.headers['Content-type'] = 'application/json';
    dio.options.headers['Authorization'] = '${AgentSamaWeb.authorization}';
    dio.options.headers['imei'] = '$imei';
    dio.options.headers['iduser'] = '$iduser';
    dio.options.headers['phone'] = '$phone';

    String finalMon = montant!.replaceAll(RegExp(r"\s\b|\b\s"), "");
    // String finalPhone = numero.replaceAll( RegExp(r"\s\b|\b\s"), "");

    Map<String, String> bodyJson = HashMap();
    //   bodyJson['phoner'] = '${countries[_selectedCountryIndex].dialCode}$finalPhone';
    bodyJson['login'] = '$login';
    bodyJson['loginpassword'] = '$password';
    bodyJson['montant'] = '$finalMon';
    print(bodyJson);
    String result = await Services.httpPostRequest(dio, url, bodyJson);
    print(result);
    if (result == "error") {
      setState(() {
        _progressBarActive = false;
      });
    } else {
      setState(() {
        _progressBarActive = false;
      });
      var data = json.decode(result);
      var sta = data["status"];
      var msg = data["msg"];

      if (sta == 0) {
        CustomDialogBox().onErrorAlertDialog(context, msg);
      } else {
        onSuccessAlertDialog(msg);
      }
    }
  }

  onSuccessAlertDialog(text) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            //  title: Text(title),
            content: Text(text,
                style: const TextStyle(fontSize: 16.0, color: kSamaBleuColor)),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Get.offNamedUntil(homePageRoute, (route) => false);
                },
                style: TextButton.styleFrom(
                  primary: Colors.transparent,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(colors: [
                        kSamaBleuColor,
                        kSamaBleuColor,
                        kSamaBleuColor,
                      ])),
                  child: const Center(
                    child: Text(
                      "Continuer",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}
