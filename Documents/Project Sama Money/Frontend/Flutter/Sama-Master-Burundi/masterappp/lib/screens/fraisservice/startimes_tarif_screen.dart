import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:masterappp/Services/services.dart';
import 'package:masterappp/config/config.dart';
import 'package:masterappp/constants/constants.dart';
import 'package:masterappp/widgets/custom_app_bar.dart';
import 'package:masterappp/widgets/custom_drawer.dart';
import 'package:masterappp/widgets/custom_header_text.dart';
import 'package:masterappp/widgets/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StarTimesTarifScreen extends StatefulWidget {
  @override
  _StarTimesTarifScreenState createState() => _StarTimesTarifScreenState();
}

class _StarTimesTarifScreenState extends State<StarTimesTarifScreen> {
  String imei = "";
  String iduser = "";
  String login = '';
  String phone = "";

  String pass = "";
  String user = "";
  String frais = "";

  List? dataItem;

  var donnee;

  // bool _progressBarActive = true;
  bool _progressBarActive = false;

  _makeTarifRequest() async {
    String url = 'startimes/bouquet';
    Dio dio = Dio();
    dio.options.headers['Content-type'] = 'application/json';
    dio.options.headers['Authorization'] = '${AgentSamaWeb.authorization}';
    dio.options.headers['imei'] = '$imei';
    dio.options.headers['iduser'] = '$iduser';
    dio.options.headers['phone'] = '$phone';

    Map<String, String> bodyJson = HashMap();
    bodyJson['login'] = '$login';
    bodyJson['loginpassword'] = '$pass';
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
      setState(() {
        donnee = data;
        dataItem = data;
        print(dataItem);
      });
    }
  }

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

    _makeTarifRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBackGroundDecoration,
      child: Scaffold(
        appBar: MyAppBar(),
        backgroundColor: Colors.transparent,
        drawer: MyDrawer(),
        // bottomNavigationBar: MyHomeBottomNavBar(),
        body: _progressBarActive == true
            ? CustomCircularProgresssDialog()
            : getBody(),
      ),
    );
  }

  Widget getBody() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: <Widget>[
            CustomHeaderText(
              text: "Bouquets Canal +",
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 15.0, bottom: 10.0),
                    child: const Text("Bouquets",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
                Container(
                    margin: const EdgeInsets.only(right: 15.0, bottom: 10.0),
                    child: const Text("Coût Mensuel",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
              ],
            ),
            Container(
              height: 400,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dataItem == null ? 0 : dataItem!.length,
                itemBuilder: (BuildContext context, int index) {
                  var donn = dataItem![index]["tarifstartimes"];
                  return Container(
                    height: 35,
                    color: (index % 2 == 0)
                        ? Color(0xFFa7a3a3)
                        : Color(0xFFFFFFFF),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 15.0),
                            child: Text(donn[0]["bouquet"],
                                style: const TextStyle(fontSize: 14.0))),
                        Container(
                            margin: const EdgeInsets.only(right: 15.0),
                            child: Text(donn[0]["montant"],
                                style: const TextStyle(fontSize: 16.0))),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
}
