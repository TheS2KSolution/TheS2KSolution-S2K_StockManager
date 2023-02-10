import 'dart:collection';
import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:masterappp/Services/fingerprint_class.dart';
import 'package:masterappp/Services/services.dart';
import 'package:masterappp/config/config.dart';
import 'package:masterappp/constants/constants.dart';
import 'package:masterappp/internet/internet_checker.dart';
import 'package:masterappp/routes/route_constants.dart';
import 'package:masterappp/widgets/progress_dialog.dart';
import 'package:masterappp/widgets/show_dialog_box.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? phoneNo;
  String? login;
  String? iduser;
  String? imei;
  String? phone;

  String? codeCount;

  bool _progressBarActive = false;

  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController _controller = TextEditingController();

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
        codeCount = phone!.substring(0, 3);
        var ph = phone!.substring(3);
        var phS = StringUtils.addCharAtPosition(ph, " ", 2);
        phoneNo = StringUtils.addCharAtPosition(phS, " ", 6);
        login = tat['login'];

        iduser = tat['iduser'];
        imei = tat['imei'];
      });

      if (AgentSamaWeb.identifiantBox!.isNotEmpty) {
        var identifiant = await AgentSamaWeb.identifiantBox!
            .get(AgentSamaWeb.identifiantHiveKey);
        print(identifiant);
        setState(() {
          _isVisible = true;
          identifiant = login;
          _controller.text = login!;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBackGroundDecoration,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: _progressBarActive == true
              ? CustomCircularProgresssDialog()
              : getBody(),
        ),
      ),
    );
  }

  Widget getBody() => Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: EdgeInsets.all(0.0),
                  child:
                      SvgPicture.asset('images/fond_rouge.svg', height: 40.0),
                ),

                const SizedBox(
                  height: 20,
                ),
                Form(key: formKey, child: _buildContainer()),
                //  _buildSignUpBtn(),
              ],
            )
          ],
        ),
      );

  String? identifiant, password = "4444";

  Widget _buildEmailRow() {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: TextFormField(
        controller: _controller,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          setState(() {
            identifiant = value;
          });
        },
        decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            hintStyle: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.normal),
            hintText: "Identifiant"),
        style: const TextStyle(
            letterSpacing: 1.0,
            fontSize: 22,
            color: Color(0xFFD61A01),
            fontWeight: FontWeight.bold),
        validator: (String? value) {
          if (value!.isEmpty) {
            return "Veuillez renseigner l'identifiant";
          } else
            return null;
        },
      ),
    );
  }

  Widget _buildPasswordRow() {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: TextFormField(
        keyboardType: TextInputType.number,
        obscureText: true,
        onChanged: (value) {
          setState(() {
            password = value;
          });
        },
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.white,
          ),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.normal),
          hintText: "Mot de passe",
        ),
        style: const TextStyle(
            letterSpacing: 1.0,
            fontSize: 22,
            color: Color(0xFFD61A01),
            fontWeight: FontWeight.bold),
        validator: (String? value) {
          if (value!.isEmpty) {
            return "Veuillez renseigner mot passe.";
          } else if (value.length < 4) {
            return "Votre mot de passe est trop court.";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildLoginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.8 * (MediaQuery.of(context).size.height / 20),
          width: 6.5 * (MediaQuery.of(context).size.width / 10),
          margin: const EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 5.0,
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            onPressed: () {
              _submitCommand();
            },
            child: Text(
              "Se connecter",
              style: TextStyle(
                color: Color(0xFFD61A01),
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSocialBtnRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            bool getState = await FingerPrint.authenticateUser();

            if (getState) {
              print('Authorized');

              Get.offAndToNamed(homePageRoute);
            } else {
              print('Not Authorized');
            }
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.0)
              ],
            ),
            child: const Icon(
              Icons.fingerprint_outlined,
              color: Color(0xFFD61A01),
              size: 28,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: const BoxDecoration(
              color: Colors.white70,
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              //  crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 26,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '$codeCount $phoneNo',
                        style: const TextStyle(
                            color: Color(0xFFD61A01),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildEmailRow(),
                const SizedBox(
                  height: 10,
                ),
                _buildPasswordRow(),
                // _buildForgetPasswordButton(),
                const SizedBox(
                  height: 30,
                ),
                _buildLoginButton(),

                // _buildOrRow(),
                Visibility(visible: _isVisible, child: _buildSocialBtnRow()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _submitCommand() async {
    //get state of our Form
    final form = formKey.currentState;
    if (form!.validate()) {
      setState(() {
        _progressBarActive = true;
      });
      bool connectState = await InternetConnectivityCheck().isInternet();
      if (connectState) {
        _makePostRequest();
        print("=======================================");
        print("CONNEXION LOGIN GOOD");
        print("=======================================");
        // Get.offNamed(passwordDefaultScreenRoute);
        // Get.toNamed(homePageRoute);
      } else {
        setState(() {
          _progressBarActive = false;
        });
        CustomDialogBox().noInternetSimpleshowDialog(
            context, "Pas d'Internet", "Vous n'êtes pas connecté à internet.");
      }
    }
  }

  _makePostRequest() async {
    String url = 'master/login';
    Dio dio = new Dio();
    dio.options.headers['Content-type'] = 'application/json';
    dio.options.headers['Authorization'] = '${AgentSamaWeb.authorization}';
    dio.options.headers['imei'] = '$imei';
    dio.options.headers['iduser'] = '$iduser';
    dio.options.headers['phone'] = '$phone';

    Map<String, String> bodyJson = new HashMap();
    bodyJson['login'] = '$login';

    bodyJson['imei'] = '$imei';
    bodyJson['phone'] = '$phone';
    bodyJson['iduser'] = '$iduser';
    bodyJson['loginpassword'] = '$password';
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
      var sta = data["status"];
      var msg = data["msg"];

      if (sta == 0) {
        CustomDialogBox().onErrorAlertDialog(context, msg);
      } else {
        print('default');

        if (password == '444444' || password == '333333') {
          Get.offNamed(passwordDefaultScreenRoute);
        } else {
          setState(() {
            _progressBarActive = false;
          });
          print(password);
          _saveIdentifiant(password);

          Get.offAndToNamed(homePageRoute);
        }
      }
    }
  }

  _saveIdentifiant(result) async {
    await AgentSamaWeb.identifiantBox!
        .put(AgentSamaWeb.identifiantHiveKey, result);
  }
}
