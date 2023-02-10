import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:masterappp/config/config.dart';
import 'package:masterappp/constants/constants.dart';
import 'package:masterappp/routes/route_constants.dart';


class MyDrawer extends StatefulWidget {
  @override
  MyDrawerState createState() => MyDrawerState();
}

class MyDrawerState extends State<MyDrawer> {
  String? phoneNo = "+22390232399";
  String? login;
  String? iduser;
  String? imei;
  String? phone = "+22390232399";
  String? nom = "Bagayogo Youba";

  //String codeCount;

  bool _progressBarActive = false;

  final GlobalKey<FormState> formKey = GlobalKey();

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
        nom = tat['nomPrenom'];
      });

      if (AgentSamaWeb.identifiantBox!.isNotEmpty) {
        var identifiant = await AgentSamaWeb.identifiantBox!
            .get(AgentSamaWeb.identifiantHiveKey);
        print(identifiant);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBackGroundDecoration,
      child: SafeArea(
        child: SizedBox(
          width: 250,
          child: Container(
            child: Drawer(
              child: Container(
                decoration: kBackGroundDecoration,
                child: Column(
                  children: <Widget>[
                    DrawerHeader(
                      child: Column(
                        children: [
                          Visibility(
                            // visible: networkBackPhoto,
                            child: Container(
                                color: Colors.transparent,
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: SvgPicture.asset(
                                  "images/fond_rouge.svg",
                                  width: 100,
                                  height: 50,
                                )),
                          ),
                          Text(
                              //getLangueValue(context, DrawerC, DrawerTexte1)+nom,
                              nom! == null || nom!.isEmpty ? '' : nom!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                  color: Colors.white)),
                          Text(
                              //getLangueValue(context, DrawerC, DrawerTexte2)+ phone,
                              phone! == null || phone!.isEmpty ? '' : phone!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                  color: Colors.white)),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text("Envoi d'UV",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.0,
                                  color: Colors.white70)),
                          const Text("Deconnexion",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.0,
                                  color: Colors.white70)),
                        ],
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                    buildMenuItem("Page d'accueil", onTap: () {
                      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      //     MyHomePage()), (Route<dynamic> route) => false);

                      Get.offNamedUntil(homePageRoute, (route) => false);
                    }),
                    const Divider(
                      height: 2.0,
                      color: Color(0xFFDDE2EC),
                      thickness: 1.0,
                    ),
                    buildMenuItem("Historique de transactions", onTap: () {
                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //     HistoriqueScreenRoute,
                      //     ModalRoute.withName(MyHomePageRoute));
                      Get.offNamedUntil(historiquePageRoute, (route) => false);
                    }),
                    const Divider(
                      height: 2.0,
                      color: Color(0xFFDDE2EC),
                      thickness: 1.0,
                    ),
                    buildMenuItem("Modifier mot de passe", onTap: () {
                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //     passwordScreenRoute,
                      //     ModalRoute.withName(MyHomePageRoute));
                      Get.offNamedUntil(
                          passwordEditPageRoute, (route) => false);
                    }),
                    const Divider(
                      height: 2.0,
                      color: Color(0xFFDDE2EC),
                      thickness: 1.0,
                    ),
                    buildMenuItem("Envoi d'UV", onTap: () {
                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //     EnvoiUvScreenRoute,
                      //     ModalRoute.withName(MyHomePageRoute));
                      Get.offNamedUntil(envoiUvPageRoute, (route) => false);
                    }),
                    const Divider(
                      height: 2.0,
                      color: Color(0xFFDDE2EC),
                      thickness: 1.0,
                    ),
                    buildMenuItem("Deconnexion", onTap: () {
                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //     LoginScreenRoute, (Route<dynamic> route) => false);
                      Get.offNamedUntil(loginScreenRoute, (route) => false);
                    }),
                    const Divider(),
                    const SizedBox(
                      height: 30,
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: const Center(
                          child: Text(
                            "SAMA Master v1.0.0",
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: kSamaRougeDegradeColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Opacity buildMenuItem(String title,
      {double opacity = 1.0,
      IconData? icon,
      Color color = Colors.white70,
      GestureTapCallback? onTap}) {
    return Opacity(
      opacity: opacity,
      child: Center(
        child: ListTile(
          onTap: onTap,
          title: Column(
            children: <Widget>[
              const SizedBox(
                height: 5.0,
              ),
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
                      color: color)),
              const SizedBox(
                height: 5.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
