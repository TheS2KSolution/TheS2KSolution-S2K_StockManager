import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:masterappp/config/config.dart';
import 'package:masterappp/constants/constants.dart';
import 'package:masterappp/constants/flutter_pattern.formatter.dart';
import 'package:masterappp/constants/important_text_constant.dart';
import 'package:masterappp/constants/text_formatter.dart';
import 'package:masterappp/screens/envoi_uv_valid_screen.dart';
import 'package:masterappp/widgets/custom_app_bar.dart';
import 'package:masterappp/widgets/custom_drawer.dart';
import 'package:masterappp/widgets/custom_header_text.dart';
import 'package:masterappp/widgets/envoyer_button.dart';


class EnvoiUvScreen extends StatefulWidget {
  const EnvoiUvScreen({Key? key}) : super(key: key);

  @override
  _EnvoiUvScreenState createState() => _EnvoiUvScreenState();
}

class _EnvoiUvScreenState extends State<EnvoiUvScreen> {
  final _formKey = GlobalKey<FormState>();

  String? numero = '';
  String? montant = '';

  String? pass = '';
  String? login;
  String? iduser;
  String? imei;
  String? phone;
  // String montant = '';
  // bool _progressBarActive = false;
  bool _progressBarActive = true;

  String password = '';

  final GlobalKey<FormState> formKeyAlert = GlobalKey();

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
  }

  Widget _buildPhoneDepot() => Expanded(
        child: TextFormField(
            decoration: kTextFieldDecoration.copyWith(
                hintText: "Numéro du bénéficiaire"),
            textAlign: TextAlign.start,
            autocorrect: false,
            maxLines: 1,
            enabled: true,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              TestMaskFormatter(
                mask: 'xx xxx xxx',
                separator: ' ',
              ),
            ],
            onChanged: (String value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
              setState(() {
                numero = value;
              });
            },
            onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
              setState(() {
                numero = value;
              });
            },
            validator: (String? value) {
              if (value!.isEmpty) {
                return "Veuillez renseigner le numéro.";
              } else if (value.length < 10) {
                return "Numéro de téléphone incorrect.";
              } else if (value.length > 10) {
                return "Numéro de téléphone incorrect.";
              } else
                return null;
            },
            textInputAction: TextInputAction.done,
            style: kTextFieldStyle),
      );
  Widget _buildMontantDepot() => TextFormField(
      decoration: kTextFieldDecoration.copyWith(hintText: "Montant"),
      textAlign: TextAlign.start,
      autofocus: false,
      maxLines: 1,
      enabled: true,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        ThousandsFormatter()
      ],
      onChanged: (String value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
        setState(() {
          montant = value;
        });
      },
      onSaved: (String? value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
        setState(() {
          montant = value;
        });
      },
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Veuillez renseigner le montant.";
        } else
          return null;
      },
      textInputAction: TextInputAction.done,
      style: kTextFieldStyle);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBackGroundDecoration,
      child: Scaffold(
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        backgroundColor: Colors.transparent,
        body: _progressBarActive == true
            ? getBody()
            : const Center(
                child: CircularProgressIndicator(
                backgroundColor: Color(0xFF01224b),
              )),
      ),
    );
  }

  Widget getBody() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child:
            ListView(physics: const ClampingScrollPhysics(), children: <Widget>[
          CustomHeaderText(
            text: "Envoi d'UV à l'agent",
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: kTextFieldContainerPadding,
                  decoration: kTextFieldContainerBoxDecoration,
                  child: Row(
                    children: <Widget>[_buildPhoneDepot()],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                    padding: kTextFieldContainerPadding,
                    decoration: kTextFieldContainerBoxDecoration,
                    child: _buildMontantDepot()),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
          ),
          EnvoyerButton(
            title: "Envoyer",
            onPressed: _submitCommand,
          ),
          const SizedBox(
            height: 40.0,
          ),
        ]),
      );

  _submitCommand() {
    final form3 = _formKey.currentState;

    if (form3!.validate()) {
      Route route = MaterialPageRoute(
          builder: (context) => EnvoiUvValidScreen(
                dialCode: '257',
                numeroValid: numero,
                montantValid: montant,
              ));
      Navigator.push(context, route);
      // Get.to(route);
    }
  }
}
