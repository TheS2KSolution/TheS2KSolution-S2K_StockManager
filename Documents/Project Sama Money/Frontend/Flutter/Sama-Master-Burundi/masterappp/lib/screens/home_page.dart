import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:masterappp/config/config.dart';
import 'package:masterappp/constants/constants.dart';
import 'package:masterappp/routes/route_constants.dart';
import 'package:masterappp/widgets/custom_app_bar.dart';
import 'package:masterappp/widgets/custom_drawer.dart';


class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  String? phoneNo = "";
  String? login;
  String? iduser;
  String? imei;
  String? phone = "";
  String? nom = "";

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
    List<Choice> choicesHomeList = const [
      Choice(
          title: "Historique de transactions",
          icon: 'images/historique.svg',
          taille: 40.0),
      Choice(
          title: "Envoi d'UV à l'agent",
          icon: 'images/envoi.svg',
          taille: 40.0),
      Choice(
          title: "Retour d'UV à SAMA",
          icon: 'images/retouruv.svg',
          taille: 40.0),
      Choice(
          title: "Conversion de Commission en UV",
          icon: 'images/conversion.svg',
          taille: 40.0),
      Choice(
          title: "Inscription agent",
          icon: 'images/inscription.svg',
          taille: 40.0),
      Choice(
          title: "Modifier le mot de passe",
          icon: 'images/password.svg',
          taille: 40.0),
      Choice(title: "Mes agents", icon: 'images/pdv.svg', taille: 40.0),
      Choice(title: "Réclamations", icon: 'images/contact.svg', taille: 40.0),
      Choice(
          title: "Frais des services", icon: 'images/frais.svg', taille: 40.0),
    ];
    return Container(
      decoration: kBackGroundDecoration,
      child: Scaffold(
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        backgroundColor: Colors.transparent,
        body: getBody(choicesHomeList),
      ),
    );
  }

  Widget getBody(List<Choice> choicesHomeList) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView(physics: ClampingScrollPhysics(), children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 0.0, left: 16.0, bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Bienvenue !",
                  style: TextStyle(
                      fontFamily: 'Avenir Next LTPro',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  nom!.isEmpty ? '' : nom!,
                  style: const TextStyle(
                      fontFamily: 'Avenir Next LTPro',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          _getGridView(choicesHomeList)
        ]),
      );

  Widget _getGridView(List<Choice> choicesHomeList) => Container(
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
            color: const Color(0xFFB3D3EA).withOpacity(.0),
            borderRadius: BorderRadius.circular(10)),
        child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            children: List.generate(choicesHomeList.length, (index) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ChoiceCard(
                    choice: choicesHomeList[index],
                    indexCC: index,
                    onTap: () {
                      goToNextPage(index);
                    },
                  ),
                ),
              );
            })),
      );

  goToNextPage(int i) {
    switch (i) {
      case 0:
        {
          Get.toNamed(historiquePageRoute);
        }
        break;

      case 1:
        {
          Get.toNamed(envoiUvPageRoute);
        }
        break;

      case 2:
        {
          Get.toNamed(retourUvPageRoute);
        }
        break;

      case 3:
        {
          Get.toNamed(convertCommPageRoute);
        }
        break;

      case 4:
        {
          Get.toNamed(agentRegistrationPageRoute);
        }
        break;
      case 5:
        {
          Get.toNamed(passwordEditPageRoute);
        }
        break;

      case 6:
        {
          Get.toNamed(mesAgentsPageRoute);
        }
        break;
      case 7:
        {
          Get.toNamed(reclamationPageRoute);
        }
        break;

      case 8:
        {
          Get.toNamed(tarifPageRoute);
        }
        break;
    }
  }
}

class Choice {
  const Choice({this.title, this.icon, this.taille});

  final String? title;
  final String? icon;
  final double? taille;
}

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key? key, this.choice, this.indexCC, this.onTap})
      : super(key: key);
  final Choice? choice;
  final int? indexCC;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Color colo = Color(0xFF01224b);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.width * 0.45,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0.0),
          child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  child: SvgPicture.asset(
                    choice!.icon!,
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.1,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          //      color: Colors.yellow
                          ),
                      //height: 40,
                      child: Center(
                        child: Text(
                          choice!.title!,
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
