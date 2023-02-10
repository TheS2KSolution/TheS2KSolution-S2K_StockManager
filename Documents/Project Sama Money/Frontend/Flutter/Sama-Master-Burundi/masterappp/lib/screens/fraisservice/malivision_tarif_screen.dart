
/*import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sama_master_app_bi/config/config.dart';
import 'package:sama_master_app_bi/constants/constants.dart';
import 'package:sama_master_app_bi/localization/localization_constants.dart';
import 'package:sama_master_app_bi/services/services.dart';
import 'package:sama_master_app_bi/widgets/custom_app_bar.dart';
import 'package:sama_master_app_bi/widgets/custom_drawer.dart';
import 'package:sama_master_app_bi/widgets/custom_header_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MalivisionTarifScreen extends StatefulWidget {
  @override
  _MalivisionTarifScreenState createState() => _MalivisionTarifScreenState();
}

class _MalivisionTarifScreenState extends State<MalivisionTarifScreen> {

  String imei = "";
  String iduser = "";
  String login='';
  String phone = "";

  String pass = "";
  String user = "";
  String frais = "";

  List dataItem;

  var donnee;

  bool _progressBarActive = true;

  _makeTarifRequest() async {
    String url = 'V1/startimes/bouquet';
    Dio dio = new Dio();
    dio.options.headers['Content-type'] = 'application/json';
    dio.options.headers['Authorization'] = '${SamaMoneyMasterApp.Authorization}';
    dio.options.headers['imei'] = '$imei';
    dio.options.headers['iduser'] = '$iduser';
    dio.options.headers['phone'] = '$phone';

    Map<String, String> bodyJson = new HashMap();
    bodyJson['login'] = '$login';
    bodyJson['lang'] = '$languageCode';
    bodyJson['loginpassword'] = '$pass';
    print(bodyJson);
    String result = await Services.httpPostRequest(dio, url, bodyJson);
    print(result);
    if (result == "error") {
      setState(() {
        _progressBarActive=false;
      });
    } else {
      setState(() {
        _progressBarActive=false;
      });
      var data = json.decode(result);
      setState(() {
        donnee = data;
        dataItem = data;
        print(dataItem);
      });
    }
  }


  String languageCode;
  getCodeLangue() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    languageCode=_prefs.getString(LANGUAGE_CODE) ?? 'fr';
    print(languageCode);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCodeLangue();
    _getUserInfo();

  }

  _getUserInfo() async {
    if (SamaMoneyMasterApp.userResulBox.isNotEmpty) {
      String rslt = await SamaMoneyMasterApp.userResulBox
          .get(SamaMoneyMasterApp.userResultHiveKey);
      var tat = json.decode(rslt);

      setState(() {
        phone = tat['phone'];
        login = tat['login'];
        iduser = tat['iduser'];
        imei = tat['imei'];
      });

      if (SamaMoneyMasterApp.identifiantBox.isNotEmpty) {
        var identifiant = await SamaMoneyMasterApp.identifiantBox
            .get(SamaMoneyMasterApp.identifiantHiveKey);
        print(identifiant);
        setState(() {
          pass=identifiant;
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
        body:Container(
          padding: EdgeInsets.symmetric(horizontal: 16,
          vertical: 10),
      child: ListView(
      physics: ClampingScrollPhysics(),
        children: <Widget>[
          CustomHeaderText(text: getLangueValue(context,Frais,FraisTitre2),),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin: EdgeInsets.only(left: 15.0, bottom: 10.0),
                  child: Text(getLangueValue(context,Frais,FraisBouquet),
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD61A0E)))),
              Container(
                  margin: EdgeInsets.only(right: 15.0, bottom: 10.0),
                  child: Text(getLangueValue(context,Frais,FraisCout),
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD61A0E)))),
            ],
          ),
          Container(
            height: 400,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: dataItem == null ? 0 : dataItem.length,
              itemBuilder: (BuildContext context, int index) {
                var donn=  dataItem[index]["tarifstartimes"];
                return Container(
                  height: 35,
                  color: (index % 2 == 0)
                      ? Color(0xFFa7a3a3)
                      : Color(0xFFFFFFFF),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 15.0),
                          child: Text(donn[0]["bouquet"],
                              style: TextStyle(fontSize: 14.0))),
                      Container(
                          margin: EdgeInsets.only(right: 15.0),
                          child: Text(donn[0]["montant"],
                              style: TextStyle(fontSize: 16.0))),
                    ],
                  ),
                );
              },
            ),
          ),
        /*  SizedBox(
            height: 20.0,
          ),
          EnvoyerButton(title: 'S\'abonner maintenant',
            onPressed: _submitCommand,),
          SizedBox(
            height: 20.0,
          ),*/
        ],
      ),)
      ),
    );
  }

 /* void _submitCommand() {
   Route route = MaterialPageRoute(
        builder: (context) =>
            MalivisionScreen());
    Navigator.pushReplacement(context, route);
  }*/
}

 */
