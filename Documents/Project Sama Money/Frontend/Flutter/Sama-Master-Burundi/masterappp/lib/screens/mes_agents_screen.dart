import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:masterappp/Services/services.dart';
import 'package:masterappp/config/config.dart';
import 'package:masterappp/constants/constants.dart';
import 'package:masterappp/models/agent_model.dart';
import 'package:masterappp/screens/agent_info_screen.dart';
import 'package:masterappp/widgets/agent_stream_builder_model.dart';
import 'package:masterappp/widgets/custom_app_bar.dart';
import 'package:masterappp/widgets/custom_drawer.dart';
import 'package:masterappp/widgets/custom_header_text.dart';


class MesAgentScreen extends StatefulWidget {
  const MesAgentScreen({Key? key}) : super(key: key);

  @override
  _MesAgentScreenState createState() => _MesAgentScreenState();
}

class _MesAgentScreenState extends State<MesAgentScreen> {
  String login = "";
  String pass = "";
  String imei = "";
  String iduser = "";
  String phone = "";
  String nom = "";

  List? dataItem;

  bool _progressBarActive = true;

  Stream<List<AgentModel>>? histoPrincipalListStream;

  @override
  void initState() {
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

    _makeHistoPostRequest();
  }

  _makeHistoPostRequest() async {
    String url = 'membres/de_mon_reseau';
    Dio dio = Dio();
    dio.options.headers['Content-type'] = 'application/json';
    dio.options.headers['Authorization'] = '${AgentSamaWeb.authorization}';
    dio.options.headers['imei'] = '$imei';
    dio.options.headers['iduser'] = '$iduser';
    dio.options.headers['phone'] = '$phone';

    Map<String, String> bodyJson = HashMap();
    bodyJson['imei'] = '$imei';
    bodyJson['iduser'] = '$iduser';
    bodyJson['phone'] = '$phone';
    bodyJson['login'] = '$login';
    bodyJson['loginpassword'] = '$pass';

    histoPrincipalListStream = await Stream.fromFuture(
        Services.historiqueAgent(dio: dio, url: url, formData: bodyJson));

    // bool connectState = await InternetConnectivityCheck().isInternet();

    // if (connectState) {

    // } else {
    //   CustomDialogBox().noInternetSimpleshowDialog(
    //       context, "Pas d'Internet", "Vous n'êtes pas connecté à internet.");
    // }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: kBackGroundDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        body: !_progressBarActive ? Container() : getBody(height),
      ),
    );
  }

  Widget getBody(double height) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: ListView(
            //physics: ClampingScrollPhysics(),
            children: <Widget>[
              CustomHeaderText(
                text: "Mes agents",
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: height * 2 / 3,
                margin:
                    const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 30.0),
                child: AgentListBuilder(
                    stream: histoPrincipalListStream,
                    builder: (context, agents) {
                      if (agents.length >= 1) {
                        return ListView.builder(
                          itemCount: agents.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            AgentModel _agent = agents[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AgentInfoScreen(
                                              numeroAgent: _agent.phone,
                                              loginAgent: _agent.logine,
                                            )));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: (index % 2 == 0)
                                        ? Colors.white
                                        : Colors.transparent),
                                padding: const EdgeInsets.only(
                                    top: 3.0,
                                    bottom: 3.0,
                                    left: 5.0,
                                    right: 5.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(_agent.nom,
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: (index % 2 == 0)
                                                      ? Color(0xFFd61a0e)
                                                      : Colors.white)),
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Text('${_agent.phone}',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: (index % 2 == 0)
                                                    ? Color(0xFFd61a0e)
                                                    : Colors.white,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(_agent.prenom,
                                            style: TextStyle(
                                              color: (index % 2 == 0)
                                                  ? Color(0xFFd61a0e)
                                                  : Colors.white,
                                              fontSize: 14.0,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Agents non disponible.",
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Aucun agent crée pour le moment.",
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }
                    }),
              ),
            ]),
      );
}
