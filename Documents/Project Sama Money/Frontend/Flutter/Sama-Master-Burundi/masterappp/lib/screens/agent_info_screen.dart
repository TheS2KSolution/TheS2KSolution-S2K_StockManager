import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:masterappp/Services/services.dart';
import 'package:masterappp/config/config.dart';
import 'package:masterappp/constants/constants.dart';
import 'package:masterappp/internet/internet_checker.dart';
import 'package:masterappp/screens/envoi_uv_from_reseau.dart';
import 'package:masterappp/widgets/custom_app_bar.dart';
import 'package:masterappp/widgets/custom_drawer.dart';
import 'package:masterappp/widgets/custom_header_text.dart';
import 'package:masterappp/widgets/envoyer_button.dart';
import 'package:masterappp/widgets/progress_dialog.dart';
import 'package:masterappp/widgets/show_dialog_box.dart';


class AgentInfoScreen extends StatefulWidget {
  final String? loginAgent;
  final String? numeroAgent;

  const AgentInfoScreen({
    Key? key,
    this.loginAgent,
    this.numeroAgent,
  }) : super(key: key);

  @override
  _AgentInfoScreenState createState() => _AgentInfoScreenState();
}

class _AgentInfoScreenState extends State<AgentInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  String montant = '';

  String pass = '';
  String? login;
  String? iduser;
  String? imei;
  String? phone;

  bool _progressBarActive = true;

  String password = '';

  final GlobalKey<FormState> formKeyAlert = GlobalKey();

  String phoneAgent = '';
  String nomPrenom = '';
  String dateEnreg = '';
  String soldeUV = '';
  String soldeComm = '';

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

    _makePostRequest();
  }

  _makePostRequest() async {
    String url = 'agent/infos';
    Dio dio = new Dio();
    dio.options.headers['Content-type'] = 'application/json';
    dio.options.headers['Authorization'] = '${AgentSamaWeb.authorization}';
    dio.options.headers['imei'] = '$imei';
    dio.options.headers['iduser'] = '$iduser';
    dio.options.headers['phone'] = '$phone';

    // String finalMon = montant.replaceAll(new RegExp(r"\s\b|\b\s"), "");
    String finalPhone =
        widget.numeroAgent!.replaceAll(new RegExp(r"\s\b|\b\s"), "");

    Map<String, String> bodyJson = new HashMap();
    bodyJson['agentPhone'] = '${finalPhone.substring(1)}';
    bodyJson['login'] = '$login';
    bodyJson['agentLogin'] = '${widget.loginAgent}';
    bodyJson['loginpassword'] = '$pass';
    // bodyJson['montant']='$finalMon';
    print(bodyJson);

    bool connectState = await InternetConnectivityCheck().isInternet();

    if (connectState) {
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
    } else {
      CustomDialogBox().noInternetSimpleshowDialog(
          context, "Pas d'Internet", "Vous n'êtes pas connecté à internet.");
    }
  }

  TextStyle style = const TextStyle(
    fontSize: 16,
    color: Colors.white,
  );
  TextStyle styleTitle = const TextStyle(
      fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);

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
              : getBody()),
    );
  }

  Widget getBody() => Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView(physics: ClampingScrollPhysics(), children: <Widget>[
          CustomHeaderText(
            text: "Envoi d'UV à l'agent",
          ),
          Container(
            child: Table(columnWidths: const {
              0: FractionColumnWidth(0.4),
              1: FractionColumnWidth(0.6)
            }, children: [
              TableRow(children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
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
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Nom :",
                    style: style,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
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
                  child: Text(soldeUV,
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
                  child: Text(soldeComm,
                      style: styleTitle, textAlign: TextAlign.start),
                ),
              ]),
            ]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
          ),
          EnvoyerButton(
            title: "Envoi d'UV à l'agent",
            onPressed: _submitCommand,
          ),
          const SizedBox(
            height: 40.0,
          ),
        ]),
      );

  void _submitCommand() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EnvoiUvFromReseau(
                  numeroAgent: widget.numeroAgent,
                  loginAgent: widget.loginAgent,
                )));
  }
}
