import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masterappp/Services/services.dart';
import 'package:masterappp/config/config.dart';
import 'package:masterappp/constants/constants.dart';
import 'package:masterappp/constants/flutter_pattern.formatter.dart';
import 'package:masterappp/constants/important_text_constant.dart';
import 'package:masterappp/widgets/custom_app_bar.dart';
import 'package:masterappp/widgets/custom_drawer.dart';
import 'package:masterappp/widgets/custom_header_text.dart';


class SamaFraisServiceScreen extends StatefulWidget {
  @override
  _SamaFraisServiceScreenState createState() => _SamaFraisServiceScreenState();
}

class _SamaFraisServiceScreenState extends State<SamaFraisServiceScreen> {
  final _formKey = GlobalKey<FormState>();

  String montant = '';

  String? tarif;

  String errorMessage = '';

  bool _isVisible = true;

  var _controller = TextEditingController();

  void getSimulation(String res) {
    _controller.clear();

    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    Function? mathFunc = (Match match) => '${match[1]} ';
    setState(() {
      _isVisible = true;
    });
    int result = int.parse(res);
    // String finalMon = montant.replaceAll( RegExp(r"\s\b|\b\s"), "");
    // var montantFrais=  int.parse(finalMon);

    for (int i = 0; i < donnee.length; i++) {
      var tarif = donnee[i]['tarif'];
      var debut = tarif[0]['debut'];
      var fin = tarif[0]['fin'];
      var debutFrais = int.parse(debut);
      var finFrais = int.parse(fin);

      if (result >= debutFrais && result <= finFrais) {
        setState(() {
          frais = tarif[0]['frais'];
          int total =
              result + int.parse(frais.replaceAll(RegExp(r"\s\b|\b\s"), ""));
          montant =
              'Frais de retrait cash $frais depuis le compte Principal ${total.toString().replaceAllMapped(reg, mathFunc())} FBU';
        });

        break;
      } else {
        frais = '0';
        int total = result + int.parse(frais);
        montant =
            'Frais de retrait cash $frais depuis le compte Principal ${total.toString().replaceAllMapped(reg, mathFunc())} FBU';
      }
    }
  }

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
    String url = 'retrait/tarif';
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
          backgroundColor: Colors.transparent,
          appBar: MyAppBar(),
          drawer: MyDrawer(),
          //  bottomNavigationBar: MyHomeBottomNavBar(),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                CustomHeaderText(
                  text: "Frais de retrait cash",
                ),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: _isVisible,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Center(
                      child: Text(
                        montant,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: kTextFieldContainerPadding,
                    decoration: kTextFieldContainerBoxDecoration,
                    child: TextFormField(
                      controller: _controller,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: "Montant à envoyer"),
                      textAlign: TextAlign.start,
                      autofocus: false,
                      enabled: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        ThousandsFormatter()
                      ],
                      onChanged: (value) {
                        setState(() {
                          _isVisible = false;
                          String lastValue = value.replaceAll(RegExp(r' '), '');
                          tarif = lastValue;
                          print(tarif);
                        });
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Veuillez renseigner le montant.";
                        } else
                          return null;
                      },
                      textInputAction: TextInputAction.done,
                      style: kTextFieldStyle,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.transparent,
                  ),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(colors: [
                          Color(0xFF7c1e22),
                          Color(0xFFd42027),
                          Color(0xFF7c1e22),
                        ])),
                    child: const Center(
                      child: Text(
                        "Calculer le frais",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        getSimulation(
                            tarif!.replaceAll(RegExp(r"\s\b|\b\s"), ""));
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                _progressBarActive == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              strokeWidth: 5,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Chargement.. Patientez...",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(
                                      left: 15.0, bottom: 10),
                                  child: const Text("De",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white))),
                              Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: const Text(
                                    "A",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                              Container(
                                  margin: const EdgeInsets.only(
                                      right: 15.0, bottom: 10),
                                  child: const Text("FBU",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white))),
                            ],
                          ),
                          Container(
                            height: 600,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  dataItem == null ? 0 : dataItem!.length,
                              itemBuilder: (BuildContext context, int index) {
                                var donn = dataItem![index]["tarif"];
                                return Container(
                                  height: 35,
                                  color: (index % 2 == 0)
                                      ? kSamaRougeDegradeColor
                                      : Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          margin:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Text(donn[0]["debut"],
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: (index % 2 == 0)
                                                      ? Colors.white
                                                      : Colors.white),
                                              textAlign: TextAlign.left)),
                                      Container(
                                          child: Text(
                                        donn[0]["fin"],
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white),
                                        textAlign: TextAlign.left,
                                      )),
                                      Container(
                                          margin: const EdgeInsets.only(
                                              right: 15.0),
                                          child: Text(donn[0]["frais"],
                                              style: const TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.white),
                                              textAlign: TextAlign.right)),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          )),
    );
  }
}
