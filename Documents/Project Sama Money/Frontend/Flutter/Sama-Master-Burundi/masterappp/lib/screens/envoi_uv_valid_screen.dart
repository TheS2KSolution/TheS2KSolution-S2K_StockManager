import 'dart:async';
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
import 'package:masterappp/constants/important_text_constant.dart';
import 'package:masterappp/constants/text_formatter.dart';
import 'package:masterappp/internet/internet_checker.dart';
import 'package:masterappp/routes/route_constants.dart';
import 'package:masterappp/widgets/custom_app_bar.dart';
import 'package:masterappp/widgets/custom_drawer.dart';
import 'package:masterappp/widgets/custom_header_text.dart';
import 'package:masterappp/widgets/envoyer_button.dart';
import 'package:masterappp/widgets/show_dialog_box.dart';



class EnvoiUvValidScreen extends StatefulWidget {
  final String? dialCode;
  final String? numeroValid;
  final String? montantValid;

  const EnvoiUvValidScreen(
      {Key? key, this.dialCode, this.numeroValid, this.montantValid})
      : super(key: key);

  @override
  _EnvoiUvValidScreenState createState() => _EnvoiUvValidScreenState();
}

class _EnvoiUvValidScreenState extends State<EnvoiUvValidScreen> {
  // final _formKey = GlobalKey<FormState>();

  String? numero = '';
  String? montant = '';

  String? pass = '';
  String? login;
  String? iduser;
  String? imei;
  String? phone;
  // String montant = '';
  bool _progressBarActive = true;

  String? phoneAgent = '';
  String? nomPrenom = '';
  String? dateEnreg = '';
  String? soldeUV = '';
  String? soldeComm = '';

  String? password = '';

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
    _makeAgentREquestPostRequest();
  }

  _makeAgentREquestPostRequest() async {
    String url = 'agent/infos/par/phone';
    Dio dio = Dio();
    dio.options.headers['Content-type'] = 'application/json';
    dio.options.headers['Authorization'] = '${AgentSamaWeb.authorization}';
    dio.options.headers['imei'] = '$imei';
    dio.options.headers['iduser'] = '$iduser';
    dio.options.headers['phone'] = '$phone';

    // String finalMon = montant.replaceAll( RegExp(r"\s\b|\b\s"), "");
    String finalPhone =
        widget.numeroValid!.replaceAll(RegExp(r"\s\b|\b\s"), "");

    Map<String, String> bodyJson = HashMap();
    bodyJson['agentPhone'] = '257${finalPhone}';
    bodyJson['login'] = '$login';
    // bodyJson['agentLogin'] = '${widget.loginAgent}';
    bodyJson['loginpassword'] = '$pass';
    // bodyJson['montant']='$finalMon';
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
        onErrorAlertDialog(context, msg);
      } else {
        var tat = json.decode(result);

        setState(() {
          phoneAgent = tat['phoneAgent'];
          nomPrenom = tat['nomPrenom'];
          dateEnreg = tat['dateEnreg'];
          soldeUV = tat['soldeUV'];
          soldeComm = tat['soldeComm'];
        });
      }
    }
  }

  Widget _buildPhoneDepot() => Expanded(
        child: TextFormField(
            decoration: kTextFieldDecoration.copyWith(
                hintText: "Numéro du bénéficiaire"),
            textAlign: TextAlign.start,
            autocorrect: false,
            maxLines: 1,
            enabled: true,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              TestMaskFormatter(
                mask: 'xx xxx xxx',
                separator: ' ',
              ),
            ],
            onChanged: (String value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
              setState(() {
                numero = value;
              });
            },
            onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
              setState(() {
                numero = value;
              });
            },
            validator: (String? value) {
              if (value!.isEmpty) {
                return "Veuillez renseigner le numéro.";
              } else if (value.length < 10) {
                return "Numéro de téléphone incorrect.";
              } else if (value.length > 10) {
                return "Numéro de téléphone incorrect.";
              } else
                return null;
            },
            textInputAction: TextInputAction.done,
            style: kTextFieldStyle),
      );

  TextStyle style = const TextStyle(
    fontSize: 16,
    color: Colors.white,
  );
  TextStyle styleTitle = const TextStyle(
      fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBackGroundDecoration,
      child: Scaffold(
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        backgroundColor: Colors.transparent,
        body: _progressBarActive == false
            ? getBody()
            : const Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              )),
      ),
    );
  }

  Widget getBody() => Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView(physics: ClampingScrollPhysics(), children: <Widget>[
          CustomHeaderText(
            text: "Envoi d'UV à l'agent",
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            child: Table(columnWidths: const {
              0: FractionColumnWidth(0.4),
              1: FractionColumnWidth(0.6)
            }, children: [
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "N° de téléphone :",
                    style: style,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('$phoneAgent',
                      style: styleTitle, textAlign: TextAlign.start),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Nom :",
                    style: style,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('$nomPrenom',
                      style: styleTitle, textAlign: TextAlign.start),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Date Enreg :",
                    style: style,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('$dateEnreg',
                      style: styleTitle, textAlign: TextAlign.start),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "UV :",
                    style: style,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(soldeUV!,
                      style: styleTitle, textAlign: TextAlign.start),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Comm",
                    style: style,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(soldeComm!,
                      style: styleTitle, textAlign: TextAlign.start),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Montant",
                    style: style,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(widget.montantValid.toString() + ' FBu',
                      style: styleTitle, textAlign: TextAlign.start),
                ),
              ]),
            ]),
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
    //  final form = .currentState;
    showCustomDialogWithImage(context, widget.montantValid!, phoneAgent!);
  }

  void showCustomDialogWithImage(
      BuildContext context, String montant, String numero) {
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
                      "Vous allez faire un dépôt de " +
                          montant +
                          " FBU au " +
                          '257 ' +
                          numero +
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
                            Get.back();
                          },
                          child: Container(
                            child: const Center(
                              child: Text(
                                "Annuler",
                                style: TextStyle(
                                    // color:kUbaRougeColor,
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

                              // Get.back();
                              Navigator.of(context).pop();
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
      print("===================================================");
      print("FINGERPRINT WORKS");
      print("===================================================");
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
    String url = 'depot/uv/agent';
    Dio dio = Dio();
    dio.options.headers['Content-type'] = 'application/json';
    dio.options.headers['Authorization'] = '${AgentSamaWeb.authorization}';
    dio.options.headers['imei'] = '$imei';
    dio.options.headers['iduser'] = '$iduser';
    dio.options.headers['phone'] = '$phone';

    String finalMon = widget.montantValid!.replaceAll(RegExp(r"\s\b|\b\s"), "");
    String finalPhone = phoneAgent!.replaceAll(RegExp(r"\s\b|\b\s"), "");

    Map<String, String> bodyJson = HashMap();
    bodyJson['agentPhone'] = '$finalPhone';
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

  onErrorAlertDialog(BuildContext context, text) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color(0xFFD61A0E),
            content: Text(text,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                )),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Get.back();
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
                        Color(0xFFFFFFFF),
                        Color(0xFFFFFFFF),
                        Color(0xFFFFFFFF),
                      ])),
                  child: const Center(
                    child: Text(
                      'OK',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFFD61A0E),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          );
        });
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
