import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:masterappp/Services/services.dart';
import 'package:masterappp/config/config.dart';
import 'package:masterappp/constants/constants.dart';
import 'package:masterappp/constants/important_text_constant.dart';
import 'package:masterappp/internet/internet_checker.dart';
import 'package:masterappp/routes/route_constants.dart';
import 'package:masterappp/widgets/envoyer_button.dart';
import 'package:masterappp/widgets/progress_dialog.dart';
import 'package:masterappp/widgets/show_dialog_box.dart';


class PasswordDefaultScreen extends StatefulWidget {
  @override
  _PasswordDefaultScreenState createState() => _PasswordDefaultScreenState();
}

class _PasswordDefaultScreenState extends State<PasswordDefaultScreen> {
  var _controllerAncien = TextEditingController();
  var _controllerNouveau = TextEditingController();
  var _controllerConfirm = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _progressBarActive = false;

  String? phone;
  String? login;
  String? iduser;
  String? imei;
  String? pass;

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
        //  codeCount=phone.substring(0,3);
        // var ph = phone.substring(3);
        // var phS = StringUtils.addCharAtPosition(ph, " ", 2);
        //  phoneNo = StringUtils.addCharAtPosition(phS, " ", 6);
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
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBackGroundDecoration,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: kSamaRougeDegradeColor,
            title: const Text("Modifier mot de passe initial",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
                textAlign: TextAlign.center),
          ),
          body: _progressBarActive == true
              ? CustomCircularProgresssDialog()
              : getBody()),
    );
  }

  Widget getBody() => Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: kTextFieldContainerPadding,
                    decoration: kTextFieldContainerBoxDecoration,
                    child: TextFormField(
                        controller: _controllerAncien,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: "Ancien mot de passe"),
                        textAlign: TextAlign.start,
                        autofocus: false,
                        enabled: true,
                        maxLines: 1,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Veuillez renseigner ancien mot de passe.";
                          } else if (value.length < 4)
                            return "Ancien mot de passe incorrect.";
                          else
                            return null;
                        },
                        textInputAction: TextInputAction.done,
                        onChanged: (String value) {
                          setState(() {
                            // ancien = value;
                          });
                        },
                        onSaved: (String? value) {
                          setState(() {
                            //  ancien = value;
                          });
                        },
                        style: kTextFieldStyle),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: kTextFieldContainerPadding,
                    decoration: kTextFieldContainerBoxDecoration,
                    child: TextFormField(
                        controller: _controllerNouveau,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: "Nouveau mot de passe"),
                        textAlign: TextAlign.start,
                        autofocus: false,
                        enabled: true,
                        maxLines: 1,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Veuillez renseigner nouveau mot de passe.";
                          } else if (value.length < 4)
                            return "Nouveau mot de passe incorrect.";
                          else
                            return null;
                        },
                        textInputAction: TextInputAction.done,
                        onChanged: (String value) {
                          setState(() {
                            // nouveau = value;
                          });
                        },
                        onSaved: (String? value) {
                          setState(() {
                            //   nouveau = value;
                          });
                        },
                        style: kTextFieldStyle),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: kTextFieldContainerPadding,
                    decoration: kTextFieldContainerBoxDecoration,
                    child: TextFormField(
                        controller: _controllerConfirm,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: "Confirmez nouveau mot de passe"),
                        textAlign: TextAlign.start,
                        autofocus: false,
                        enabled: true,
                        maxLines: 1,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Veuillez renseigner nouveau mot de passe.";
                          } else if (value.length < 4)
                            return "Nouveau mot de passe incorrect.";
                          else
                            return null;
                        },
                        textInputAction: TextInputAction.done,
                        onChanged: (String value) {
                          setState(() {
                            //   confnouveau = value;
                          });
                        },
                        onSaved: (String? value) {
                          setState(() {
                            //    confnouveau = value;
                          });
                        },
                        style: kTextFieldStyle),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            EnvoyerButton(
              title: "Modifier",
              onPressed: _submitCommand,
            ),
            SizedBox(
              height: 40.0,
            ),
          ],
        ),
      );

  void _submitCommand() {
    //get state of our Form
    final form = _formKey.currentState;

    if (form!.validate()) {
      if (_controllerNouveau.text.trim().toString() ==
          _controllerConfirm.text.trim().toString()) {
        setState(() {
          _progressBarActive = true;
        });
        goToInternet();
      } else {
        //_controllerNouveau.clear();
        //_controllerConfirm.clear();

        CustomDialogBox().twoFieldIncorrectshowDialog(
            context, "Les deux nouveaux mot de passe ne sont pas identiques.");
      }
    }
  }

  goToInternet() async {
    bool connectState = await InternetConnectivityCheck().isInternet();
    if (connectState) {
      _makePostRequest();
      print("=======================================");
      print("MODIFIED GOOD");
      print("=======================================");
    } else {
      setState(() {
        _progressBarActive = false;
      });
      CustomDialogBox().noInternetSimpleshowDialog(
          context, "Pas d'Internet", "Vous n'êtes pas connecté à internet.");
    }
  }

  _makePostRequest() async {
    String url = 'modifier/pwd';
    Dio dio = new Dio();
    dio.options.headers['Content-type'] = 'application/json';
    dio.options.headers['Authorization'] = '${AgentSamaWeb.authorization}';
    dio.options.headers['imei'] = '$imei';
    dio.options.headers['iduser'] = '$iduser';
    dio.options.headers['phone'] = '$phone';

    Map<String, String> bodyJson = HashMap();
    bodyJson['login'] = '$login';
    bodyJson['loginpassword'] = '${_controllerAncien.text.trim().toString()}';
    bodyJson['passwordn'] = '${_controllerNouveau.text.trim().toString()}';
    bodyJson['passwordnv'] = '${_controllerConfirm.text.trim().toString()}';
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
        _controllerAncien.clear();

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
            backgroundColor: kSamaRougeDegradeColor,
            //  title: Text(title),
            content: Text(text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                )),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _saveIdentifiant(_controllerNouveau.text.trim().toString());
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      loginScreenRoute, (Route<dynamic> route) => false);
                },
                style: TextButton.styleFrom(primary: Colors.transparent),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(colors: [
                        Color(0xFFFFFFFF),
                        Color(0xFFFFFFFF),
                        Color(0xFFFFFFFF),
                      ])),
                  child: const Center(
                    child: Text(
                      "Continuer",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: kSamaRougeDegradeColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  _saveIdentifiant(result) async {
    await AgentSamaWeb.identifiantBox!
        .put(AgentSamaWeb.identifiantHiveKey, result);
  }
}
