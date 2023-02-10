import 'package:flutter/material.dart';

import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masterappp/Services/services.dart';
import 'package:masterappp/config/config.dart';
import 'package:masterappp/constants/constants.dart';
import 'package:masterappp/widgets/show_dialog_box.dart';


class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final PreferredSizeWidget? bottom;
  MyAppBar({this.bottom});

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();

  @override
  // Size get preferredSize => new Size.fromHeight(110.0);
  Size get preferredSize => bottom == null
      ? Size(56, AppBar().preferredSize.height)
      : Size(56, 80 + AppBar().preferredSize.height);
}

class _AppBarWidgetState extends State<MyAppBar> {
  bool isSwitched = false;

  String soldeUv = "";
  String soldeComm = "";

  bool _progressBarActive = false;

  String soldePrincipal = '';
  String soldeSalaire = '';

  String user = '';
  String pass = '';
  String login = '';

  String imei = "";
  String iduser = "";
  String phone = "";
  var rslt;

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
      //  print(rslt);
      var tat = json.decode(rslt);
      print(tat);
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
          //_isVisible = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kSamaRougeDegradeColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      centerTitle: true,
      title: SvgPicture.asset(
        'images/fond_rouge.svg',
        width: 70.0,
        height: 30.0,
      ),
      bottom: widget.bottom,
      actions: <Widget>[
        Container(
            child: Column(
          children: [
            Row(
              children: [
                _progressBarActive == true
                    ? Container(
                        margin: EdgeInsets.only(top: 25, right: 10),
                        height: 10,
                        width: 100,
                        child: const LinearProgressIndicator(
                          //  backgroundColor: kUbaRougeColor,
                          backgroundColor: Colors.white,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ))
                    : Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(
                          height: 20,
                          child: Row(
                            children: <Widget>[
                              const Text('Solde',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  )),
                              Switch(
                                value: isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value;
                                    print(isSwitched);
                                    if (isSwitched) {
                                      setState(() {
                                        _progressBarActive = true;
                                      });
                                      _makePostRequestSolde();
                                    }
                                  });
                                },
                                //  activeTrackColor:kUbaRougeColor ,
                                activeTrackColor: Colors.white,
                                activeColor: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            )
          ],
        ))
      ],
    );
  }

  _makePostRequestSolde() async {
    String url = 'solde';
    Dio dio = Dio();
    dio.options.headers['Content-type'] = 'application/json';
    dio.options.headers['Authorization'] = '${AgentSamaWeb.authorization}';
    dio.options.headers['imei'] = '$imei';
    dio.options.headers['iduser'] = '$iduser';
    dio.options.headers['phone'] = '$phone';

    Map<String, String> bodyJson = HashMap();
    //   bodyJson['imei'] = '$imei';
    //  bodyJson['iduser'] = '$iduser';
    //  bodyJson['phone'] = '$phone';
    bodyJson['login'] = '$login';
    bodyJson['loginpassword'] = '$pass';
    print(bodyJson);
    String result = await Services.httpPostRequest(dio, url, bodyJson);
    print(result);

    if (result == "error") {
      setState(() {
        _progressBarActive = false;
        isSwitched = false;
      });
    } else {
      setState(() {
        _progressBarActive = false;
        isSwitched = false;
      });

      var data = json.decode(result);
      var sta = data["status"];
      var msg = data["msg"];
      // var resultat = data["resultat"];

      if (sta == 0) {
        CustomDialogBox().onErrorAlertDialog(context, msg);
      } else {
        var rsdt = msg.toString().split(',');
        soldeUv = rsdt[0];
        soldeComm = rsdt[1];
        showCustomDialogWithImage(context);
      }
    }
  }

  void showCustomDialogWithImage(BuildContext context) {
    Dialog dialogWithImage = Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 250.0,
        width: 400.0,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  )),
              child: Container(
                  decoration: const BoxDecoration(
                      gradient:
                          LinearGradient(begin: Alignment.center, colors: [
                        Color(0xFFf3797d),
                        Color(0xFFd42027),
                        Color(0xFF7c1e22),
                      ]),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(100))),
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    width: 400,
                    height: 50,
                    child: const Text(
                      'Solde',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  )),
            ),
            Container(
              decoration: const BoxDecoration(
                  // color: kUbaRougeColor,
                  color: Color(0xFFd61a0e),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(60))),
                child: Column(children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0, left: 5),
                    child: Center(
                      child: Text(
                        '$soldeUv',
                        style: const TextStyle(
                            color: Color(0xFFd61a0e),
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0, left: 5),
                    child: Center(
                      child: Text(
                        '$soldeComm',
                        style: const TextStyle(
                            // color: kUbaRougeColor,
                            color: Color(0xFFd61a0e),
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    width: 400.0,
                    padding: EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {
                              isSwitched = false;
                              _progressBarActive = false;
                            });
                          },
                          style:
                              TextButton.styleFrom(primary: Colors.transparent),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(colors: [
                                  Color(0xFFd61a0e),
                                  Color(0xFFd61a23),
                                  Color(0xFFd6340e),
                                ])),
                            child: const Center(
                              child: Text(
                                'OK',
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
                    height: 40,
                    decoration: const BoxDecoration(
                        gradient:
                            LinearGradient(begin: Alignment.topCenter, colors: [
                          Color(0xFFf3797d),
                          Color(0xFFd42027),
                          Color(0xFF7c1e22),
                        ]),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                  ),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => dialogWithImage);
  }
}
