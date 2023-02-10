import 'dart:collection';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:masterappp/config/config.dart';
import 'package:masterappp/constants/constants.dart';
import 'package:masterappp/models/histo_principale_model.dart';
import 'package:masterappp/widgets/custom_app_bar.dart';
import 'package:masterappp/widgets/custom_drawer.dart';
import 'package:masterappp/widgets/custom_header_text.dart';
import 'package:masterappp/widgets/histo_principal_stream_builder_model.dart';

import '../Services/services.dart';


class HistoriqueScreen extends StatefulWidget {
  const HistoriqueScreen({Key? key}) : super(key: key);

  @override
  _HistoriqueScreenState createState() => _HistoriqueScreenState();
}

class _HistoriqueScreenState extends State<HistoriqueScreen> {
  String? login = "";
  String? pass = "";
  String? imei = "";
  String? iduser = "";
  String? phone = "";
  String? nom = "";

  Stream<List<HistoPrincipalModel>>? histoPrincipalListStream;

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
    String url = 'master/histo/uv/0/2';
    Dio dio = new Dio();
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

    histoPrincipalListStream = Stream.fromFuture(Services.histoPrincipal(dio: dio, url: url, formData: bodyJson));

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
        // bottomNavigationBar: MyBottomNavigation(selectedIt: 0,),
        body: getBody(height),
      ),
    );
  }

  Widget getBody(double height) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child:
            ListView(physics: const ClampingScrollPhysics(), children: <Widget>[
          CustomHeaderText(
            text: "Historique de transactions",
          ),
          const SizedBox(
            height: 20,
          ),
          HistoPrincipalListBuilder(
              stream: histoPrincipalListStream,
              builder: (context, historiques) {
                if (historiques.length >= 1) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: historiques.length,
                    itemBuilder: (BuildContext context, int index) {
                      HistoPrincipalModel _histos = historiques[index];
                      return Container(
                        decoration: BoxDecoration(
                            color: (index % 2 == 0)
                                ? Colors.white
                                : Colors.transparent),
                        padding: const EdgeInsets.only(
                            top: 3.0, bottom: 3.0, left: 5.0, right: 5.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(_histos.type,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: (index % 2 == 0)
                                              ? const Color(0xFFd61a0e)
                                              : Colors.white)),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text('${_histos.montant} ${_histos.devise}',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: _histos.montant
                                                    .toString()
                                                    .startsWith('-') &&
                                                (index % 2 != 0)
                                            ? Colors.white
                                            : const Color(0xFFd61a0e),
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(_histos.date.toString(),
                                    style: TextStyle(
                                      color: (index % 2 == 0)
                                          ? const Color(0xFFd61a0e)
                                          : Colors.white,
                                      fontSize: 14.0,
                                    )),
                              ],
                            ),
                          ],
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
                          "Historique non disponible.",
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Aucune opération effectuée pour le moment.",
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
        ]),
      );
}
