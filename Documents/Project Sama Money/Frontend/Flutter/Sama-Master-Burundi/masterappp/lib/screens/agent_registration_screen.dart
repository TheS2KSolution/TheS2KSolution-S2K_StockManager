import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masterappp/Services/services.dart';
import 'package:masterappp/config/config.dart';
import 'package:masterappp/constants/constants.dart';
import 'package:masterappp/constants/flutter_date_formatter.dart';
import 'package:masterappp/constants/important_text_constant.dart';
import 'package:masterappp/constants/text_formatter.dart';
import 'package:masterappp/internet/internet_checker.dart';
import 'package:masterappp/routes/route_constants.dart';
import 'package:masterappp/widgets/custom_app_bar.dart';
import 'package:masterappp/widgets/custom_drawer.dart';
import 'package:masterappp/widgets/custom_header_text.dart';
import 'package:masterappp/widgets/envoyer_button.dart';
import 'package:masterappp/widgets/progress_dialog.dart';
import 'package:masterappp/widgets/show_dialog_box.dart';

class AgentRegistrationScreen extends StatefulWidget {
  const AgentRegistrationScreen({Key? key}) : super(key: key);

  @override
  _AgentRegistrationScreenState createState() =>
      _AgentRegistrationScreenState();
}

class _AgentRegistrationScreenState extends State<AgentRegistrationScreen> {
  String typePieceInscript = '';

  int currentStep = 0;
  bool complete = false;
  bool firstActive = true;
  bool secondActive = false;
  bool thirdActive = false;

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

  String? pass;
  String? user;
  String? imei;
  String? iduser;
  String? login;

  String? base64Image = '';

  File? _image;

  final _picker = ImagePicker();

  bool _isVisible = false;
  bool isExpVisible = false;

  getPhotoFromCamera() async {
    final pickedFile =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 60);
    File file = File(pickedFile!.path);
    setState(() {
      _image = file;
      base64Image = base64Encode(file.readAsBytesSync());
      _isVisible = true;
    });
  }

  getPhotoFromGallery() async {
    final pickedFile =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 60);
    setState(() {
      File file = File(pickedFile!.path);
      _image = file;
      base64Image = base64Encode(file.readAsBytesSync());
      _isVisible = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserInfo();
  }

  String? nom;
  String? phone;
  String? prenom;
  String? age;
  String? dateNaiss = '';
  String? dateDel = '';
  String? dateExpira = '';
  String? phoneNumber = '';

  String? quartier = '';
  String? ville = '';
  String? commune = '';
  String? region = '';
  String? lieuDeliv = '';
  String? lieuNaiss = '';

  String? regionValue = '';
  String? cercleValue = '';
  String? communeValue = '';

  var regionReg, cercleReg, cercleCom, communeReg;

  String typePieceValue = '';

  String numeroPiece = '';
  String dateExp = '';

  final List<String> regionList = [
    "Bubanza",
    "Bujumbura",
    "Bururi",
    "CANKUZO",
    "Cibitoke",
    "GITEGA",
    "Karusi",
    "Kayanza",
    "Kirundo",
    "Makamba",
    "Muramvya",
    "Muyinga",
    "Mwaro",
    "NGOZI",
    "RUMONGE",
    "RUTANA",
    "RUYIGI",
    "BUJA MAIRIE",
  ];

  String jsonCercle =
      '[{"province":"Bubanza","commune":["Gihanga","Mpanda","Musigati","Rugazi"]},'
      ' {"province":"Bujumbura","commune":["Isare","Kabezi","Kanyosha","Mubimbi","Mugongo-Manga",'
      '"Mukike","Mutambu","Mutimbuzi","Nyabiraba"]},'
      ' {"province":"Bururi","commune":["Bururi","Matana","Mugamba","Rutovu","Songa","Vyanda"]},'
      '{"province":"CANKUZO","commune":["Cankuzo","Cendajuru","Gisagara","Kigamba","Mishiha"]},'
      '{"province":"Cibitoke","commune":["Buganda","Bukinanyana","Mabayi","Mugina","Murwi","Rugombo"]},'
      '{"province":"GITEGA","commune":["Bugendana","Bukirasazi","Buraza","Giheta","Gishubi","Gitega",'
      '"Itaba","Makebuko","Mutaho","Nyarusange","Ryansoro"]},'
      '{"province":"Karusi","commune":["Bugenyuzi","Buhiga","Gihogazi","Gitaramuka","Mutumba",'
      '"Nyabikere","Shombo"]},'
      '{"province":"Kayanza","commune":["Kayanza","Butaganzwa","Gahombo","Gatara","Kabarore",'
      '"Kayanza","Matongo","Muhanga","Muruta","Rango"]},'
      '{"province":"Kirundo","commune":["Kirundo","Bugabira","Busoni","Bwambarangwe","Gitobe",'
      '"Kirundo","Ntega","Vumbi"]},'
      '{"province":"Makamba","commune":["Kayogoro","Kibago","Mabanda","Makamba","Nyanza-Lac",'
      '"Vugizo"]},{"province":"Muramvya","commune":["Bukeye","Kiganda","Mbuye","Muramvya","Rutegama",'
      '"Muramvya"]},{"province":"Muyinga","commune":["Muyinga","Buhinyuza","Butihinda","Gashoho",'
      '"Gasorwe","Giteranyi","Muyinga","Mwakiro"]},{"province":"Mwaro",'
      '"commune":["Bisoro","Gisozi","Kayokwe","Ndava","Nyabihanga","Rusaka"]},'
      '{"province":"NGOZI","commune":["Busiga","Gashikanwa","Kiremba","Marangara","Mwumba",'
      '"NGOZI","Nyamurenza","Ruhororo","Tangara"]},'
      '{"province":"RUMONGE","commune":["Bugarama","Burambi","Buyengero","Muhuta","Rumonge"]},'
      '{"province":"RUTANA","commune":["Bukemba","Giharo","Gitanga","Mpinga-Kayove","Musongati",'
      '"Rutana"]},{"province":"RUYIGI","commune":["Butaganzwa","Butezi",'
      '"Bweru","Gisuru","Kinyinya","Nyabitsinda","Ruyigi"]},'
      '{"province":"BUJA MAIRIE","commune":["Muha","Mukaza","Ntahangwa"]}]';

  List<String> cercleList = [''];

  List<String> communeList = [''];

  bool _progressBarActive = false;

  GlobalKey<FormState> formKeyFisrt = GlobalKey<FormState>();
  GlobalKey<FormState> formKeySecond = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyThird = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<String> spinnerTypePieceItems = [
      "CARTE D'IDENTITÉ NATIONALE",
      "PASSEPORT"
    ];

    return Container(
      decoration: kBackGroundDecoration,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: getBody(spinnerTypePieceItems),

          appBar: MyAppBar(),
          drawer: MyDrawer(),
          //  bottomNavigationBar: MyHomeBottomNavBar(defaultSelectedIndex: 0,),
        ),
      ),
    );
  }

  Widget getBody(List<String> spinnerTypePieceItems) => Container(
        color: Colors.transparent,
        child: Theme(
          // data: ThemeData(primaryColor: Color(0xFFd61a0e),
          data: ThemeData(
            canvasColor: kSamaRougeDegradeColor,
            primaryColor: Color(0xFFd61a0e),
          ),

          child: Column(children: <Widget>[
            Expanded(
              child: Stepper(
                type: StepperType.horizontal,
                steps: <Step>[
                  Step(
                      title: Icon(Icons.person, color: Colors.white),
                      isActive: firstActive,
                      state: StepState.editing,
                      content: getBodyFirst()),
                  Step(
                    isActive: secondActive,
                    state: StepState.editing,
                    title: const Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    content: getBodySecond(),
                  ),
                  Step(
                      isActive: thirdActive,
                      state: StepState.editing,
                      title: const Icon(
                        Icons.perm_identity,
                        color: Colors.white,
                      ),
                      content: _progressBarActive == true
                          ? CustomCircularProgresssDialog()
                          : getBodyThird(spinnerTypePieceItems)),
                ],
                currentStep: currentStep,
                controlsBuilder:
                    (BuildContext context, ControlsDetails controls) {
                  return Container();
                },
              ),
            ),
          ]),
        ),
      );

  Widget getBodyFirst() => Form(
      key: formKeyFisrt,
      child: ListView(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            CustomHeaderText(
              text: "Infos Personnelles",
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                  padding: kTextFieldContainerPadding,
                  decoration: kTextFieldContainerBoxDecoration,
                  child: Row(
                    children: <Widget>[
                      // InkWell(
                      //   onTap: () {
                      //     showCountries();
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(
                      //         left: 4.0, right: 4.0, top: 8.0, bottom: 8.0),
                      //     child: Row(
                      //       children: const <Widget>[
                      //         Text('223'),
                      //         Icon(Icons.arrow_drop_down, size: 16.0)
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        child: TextFormField(
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: "Numéro de l'agent"),
                            textAlign: TextAlign.start,
                            autocorrect: false,
                            enabled: true,
                            maxLines: 1,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9 ]')),
                              TestMaskFormatter(
                                mask: 'xx xxx xxx',
                                separator: ' ',
                              ),
                            ],
                            onChanged: (String value) {
                              // This optional block of code can be used to run
                              // code when the user saves the form.
                              setState(() {
                                phoneNumber = value;
                              });
                            },
                            onSaved: (String? value) {
                              // This optional block of code can be used to run
                              // code when the user saves the form.
                              setState(() {
                                phoneNumber = value;
                              });
                            },
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Veuillez renseigner votre numéro.";
                              } else if (value.length < 10)
                                return "Numéro de téléphone incorrect.";
                              else
                                return null;
                            },
                            textInputAction: TextInputAction.done,
                            style: kTextFieldStyle),
                        flex: 9,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: Container(
                        padding: kTextFieldContainerPadding,
                        decoration: kTextFieldContainerBoxDecoration,
                        child: TextFormField(
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: "Nom de famille"),
                          textAlign: TextAlign.start,
                          autofocus: false,
                          maxLines: 1,
                          enabled: true,
                          textCapitalization: TextCapitalization.characters,
                          keyboardType: TextInputType.text,
                          onChanged: (String value) {
                            setState(() {
                              nom = value.trim();
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              nom = value!.trim();
                            });
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Veuillez renseigner votre nom.";
                            } else
                              return null;
                          },
                          textInputAction: TextInputAction.done,
                          style: kTextFieldStyle,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: Container(
                        padding: kTextFieldContainerPadding,
                        decoration: kTextFieldContainerBoxDecoration,
                        child: TextFormField(
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: "Prénom(s)"),
                          textAlign: TextAlign.start,
                          autofocus: false,
                          maxLines: 1,
                          enabled: true,
                          textCapitalization: TextCapitalization.characters,
                          keyboardType: TextInputType.text,
                          onChanged: (String value) {
                            setState(() {
                              prenom = value.trim();
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              prenom = value!.trim();
                            });
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Veuillez renseigner votre prénom.";
                            } else
                              return null;
                          },
                          textInputAction: TextInputAction.done,
                          style: kTextFieldStyle,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: Container(
                        padding: kTextFieldContainerPadding,
                        decoration: kTextFieldContainerBoxDecoration,
                        child: TextFormField(
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: "Lieu de naissance "),
                          textAlign: TextAlign.start,
                          autofocus: false,
                          maxLines: 1,
                          enabled: true,
                          textCapitalization: TextCapitalization.characters,
                          keyboardType: TextInputType.text,
                          onChanged: (String value) {
                            setState(() {
                              lieuNaiss = value.trim();
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              lieuNaiss = value!.trim();
                            });
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Veuillez entrez le lieu ";
                            } else
                              return null;
                          },
                          textInputAction: TextInputAction.done,
                          style: kTextFieldStyle,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: Container(
                        padding: kTextFieldContainerPadding,
                        decoration: kTextFieldContainerBoxDecoration,
                        child: TextFormField(
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: "Date de naissance"),
                          textAlign: TextAlign.start,
                          autofocus: false,
                          maxLines: 1,
                          enabled: true,
                          //  controller: _controller,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'\d+|-|/')),
                            DateInputFormatter(),
                          ],
                          keyboardType: TextInputType.datetime,
                          onChanged: (String value) {
                            setState(() {
                              dateNaiss = value;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              dateNaiss = value;
                            });
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "La date est incorrecte.";
                            } else if (value.length < 10)
                              return "La date est incorrecte.";
                            else
                              return null;
                          },
                          textInputAction: TextInputAction.done,
                          style: kTextFieldStyle,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 40.0,
            ),
            EnvoyerButton(
              title: "Suivant",
              onPressed: _submitCommandFirst,
            ),
            const SizedBox(
              height: 40.0,
            ),
          ]));

  void _submitCommandFirst() {
    final form = formKeyFisrt.currentState;

    if (form!.validate()) {
      if (currentStep < 2) {
        setState(() {
          currentStep += 1;
          secondActive = true;
          firstActive = false;
        });
      }

      print(currentStep);
    }
  }

  Widget getBodySecond() => Form(
      //  padding: EdgeInsets.symmetric(horizontal: 10,
      //     vertical: 5),
      key: formKeySecond,
      child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            CustomHeaderText(
              text: "Votre adresse",
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: Container(
                        padding: kTextFieldContainerPadding,
                        decoration: kTextFieldContainerBoxDecoration,
                        child: DropdownButtonFormField(
                            iconDisabledColor: Colors.white,
                            iconEnabledColor: Colors.red,
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 8),
                            ),
                            hint: const Text(
                              "Sélectionnez la province de l'agent",
                              style: TextStyle(
                                  letterSpacing: 0.0,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black87),
                            ),
                            style: kTextFieldStyle,
                            value: regionValue == '' ? null : regionValue,
                            items: regionList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value.toUpperCase()),
                              );
                            }).toList(),
                            validator: (value) => value == null
                                ? "Veuillez sélectionner la province"
                                : null,
                            onChanged: (String? value) {
                              regionValue = value!;
                              region = value;
                              setState(() {
                                var data = json.decode(jsonCercle);

                                for (int i = 0; i < data.length; i++) {
                                  regionReg = data[i]['province'];
                                  cercleReg = data[i]['commune'];

                                  if (regionReg == value) {
                                    print(regionReg);
                                    print(cercleReg);
                                    break;
                                  }
                                }
                                communeList = cercleReg.toList().cast<String>();
                                communeValue = '';
                              });
                            }),
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: Container(
                        padding: kTextFieldContainerPadding,
                        decoration: kTextFieldContainerBoxDecoration,
                        child: DropdownButtonFormField(
                            iconDisabledColor: Colors.white,
                            iconEnabledColor: Colors.red,
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 8),
                            ),
                            hint: const Text(
                              "Sélectionnez la commune de l'agent",
                              style: TextStyle(
                                  letterSpacing: 0.0,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black87),
                            ),
                            style: kTextFieldStyle,
                            value: communeValue == '' ? null : communeValue,
                            items: communeList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: !value.isEmpty ? value : null,
                                child: Text(value.toUpperCase()),
                              );
                            }).toList(),
                            validator: (value) => value == null
                                ? "Sélectionnez le type de votre pièce"
                                : null,
                            onChanged: (String? value) {
                              setState(() {
                                communeValue = value;
                                commune = value;
                              });
                            }),
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: Container(
                        padding: kTextFieldContainerPadding,
                        decoration: kTextFieldContainerBoxDecoration,
                        child: TextFormField(
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: "Quartier de l'agent"),
                          textAlign: TextAlign.start,
                          autofocus: false,
                          maxLines: 1,
                          enabled: true,
                          keyboardType: TextInputType.text,
                          onChanged: (String value) {
                            setState(() {
                              quartier = value;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              quartier = value;
                            });
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Veuillez entrez le quartier";
                            } else
                              return null;
                          },
                          textInputAction: TextInputAction.done,
                          style: kTextFieldStyle,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 40.0,
            ),
            EnvoyerButton(
              title: "Suivant",
              onPressed: _submitCommandSecond,
            ),
            const SizedBox(
              height: 20.0,
            ),
          ]));

  void _submitCommandSecond() {
    final form2 = formKeySecond.currentState;

    if (form2!.validate()) {
      if (currentStep < 2) {
        setState(() {
          currentStep += 1;
          thirdActive = true;
          secondActive = false;
        });
      }

      print(currentStep);
    }
  }

  Widget getBodyThird(List<String> spinnerTypePieceItems) => Form(
      //  padding: EdgeInsets.symmetric(horizontal: 10,
      //     vertical: 5),
      key: formKeyThird,
      child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            CustomHeaderText(
              text: "Pièce d'identité",
            ),
            const SizedBox(
              height: 10.0,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: kTextFieldContainerPadding,
              decoration: kTextFieldContainerBoxDecoration,
              child: DropdownButtonFormField(
                  iconDisabledColor: Colors.white,
                  iconEnabledColor: Colors.red,
                  dropdownColor: Colors.white,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 8),
                  ),
                  hint: const Text(
                    "Sélectionnez le type de votre pièce",
                    style: TextStyle(
                        letterSpacing: 0.0,
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),
                  ),
                  style: kTextFieldStyle,
                  value: typePieceValue == '' ? null : typePieceValue,
                  items: spinnerTypePieceItems
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) => value == null
                      ? "Veuillez sélectionner le type de pièce"
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      typePieceValue = value!;
                      if (typePieceValue == 'PASSEPORT') {
                        isExpVisible = true;
                      } else {
                        isExpVisible = false;
                      }
                    });
                  }),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: kTextFieldContainerPadding,
              decoration: kTextFieldContainerBoxDecoration,
              child: TextFormField(
                decoration: kTextFieldDecoration.copyWith(
                    hintText: "Numéro de la pièce"),
                textAlign: TextAlign.start,
                autofocus: false,
                maxLines: 1,
                enabled: true,
                keyboardType: TextInputType.text,
                onChanged: (String value) {
                  setState(() {
                    numeroPiece = value;
                  });
                },
                onSaved: (String? value) {
                  setState(() {
                    numeroPiece = value!;
                  });
                },
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Veuillez entrez numéro de la pièce";
                  } else
                    return null;
                },
                textInputAction: TextInputAction.done,
                style: kTextFieldStyle,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: kTextFieldContainerPadding,
              decoration: kTextFieldContainerBoxDecoration,
              child: TextFormField(
                decoration: kTextFieldDecoration.copyWith(
                    hintText: "Date de delivrance"),
                textAlign: TextAlign.start,
                autofocus: false,
                maxLines: 1,
                enabled: true,
                //controller: _controllerDel,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'\d+|-|/')),
                  DateInputFormatter(),
                ],
                keyboardType: TextInputType.datetime,
                onChanged: (String value) {
                  setState(() {
                    dateDel = value;
                  });
                },
                onSaved: (String? value) {
                  setState(() {
                    dateDel = value;
                  });
                },
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "La date est incorrecte.";
                  } else if (value.length < 10)
                    return "La date est incorrecte.";
                  else
                    return null;
                },
                textInputAction: TextInputAction.done,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Color(0xFF01224b)),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Visibility(
              visible: isExpVisible,
              child: Container(
                padding: kTextFieldContainerPadding,
                decoration: kTextFieldContainerBoxDecoration,
                child: TextFormField(
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: "Veuillez entrez numéro de la pièce"),
                  textAlign: TextAlign.start,
                  autofocus: false,
                  maxLines: 1,
                  enabled: true,
                  // controller: _controllerExp,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'\d+|-|/')),
                    DateInputFormatter(),
                  ],
                  keyboardType: TextInputType.datetime,
                  onChanged: (String value) {
                    setState(() {
                      dateExp = value;
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      dateExp = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "La date est incorrecte.";
                    } else if (value.length < 10)
                      return "La date est incorrecte.";
                    else
                      return null;
                  },
                  textInputAction: TextInputAction.done,
                  style: kTextFieldStyle,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 9,
                  child: Container(
                    padding: kTextFieldContainerPadding,
                    decoration: kTextFieldContainerBoxDecoration,
                    child: TextFormField(
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: "Lieu de delivrance "),
                      textAlign: TextAlign.start,
                      autofocus: false,
                      maxLines: 1,
                      enabled: true,
                      keyboardType: TextInputType.text,
                      onChanged: (String value) {
                        setState(() {
                          lieuDeliv = value;
                        });
                      },
                      onSaved: (String? value) {
                        setState(() {
                          lieuDeliv = value;
                        });
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Veuillez entrez le lieu ";
                        } else
                          return null;
                      },
                      textInputAction: TextInputAction.done,
                      style: kTextFieldStyle,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                            icon: const Icon(
                              Icons.photo_camera,
                              size: 35.0,
                              color: Colors.white,
                            ),
                            tooltip: 'Choose image',
                            onPressed: () async {
                              getPhotoFromCamera();
                            }),
                        const SizedBox(
                          width: 5.0,
                        ),
                        IconButton(
                            icon: const Icon(
                              Icons.photo_library,
                              size: 35.0,
                              color: Colors.white,
                            ),
                            tooltip: 'Choose image',
                            onPressed: () async {
                              getPhotoFromGallery();
                            }),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  width: 15.0,
                ),
                const Text(
                  "Photo de la pièce d’identité",
                  style: TextStyle(fontSize: 14.0, color: Color(0xFFa7a3a3)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Visibility(
              visible: _isVisible,
              child: Center(
                child: Container(
                  width: (MediaQuery.of(context).size.width) / 2,
                  height: 50,
                  child: _image == null ? const Text('') : Image.file(_image!),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            EnvoyerButton(
              title: "Envoyer",
              onPressed: _submitCommandThird,
            ),
            const SizedBox(
              height: 20.0,
            ),
          ]));

  void _submitCommandThird() {
    final form3 = formKeyThird.currentState;

    if (form3!.validate()) {
      setState(() {
        _progressBarActive = true;
      });
      goToInternet();
    }
  }

  goToInternet() async {
    bool connectState = await InternetConnectivityCheck().isInternet();
    if (connectState) {
      _makePostRequest();
    } else {
      setState(() {
        _progressBarActive = false;
      });
      CustomDialogBox().noInternetSimpleshowDialog(
          context, "Pas d'Internet", "Vous n'êtes pas connecté à internet.");
    }
  }

  _makePostRequest() async {
    String url = 'agent/inscription';
    Dio dio = Dio();
    dio.options.headers['Content-type'] = 'application/json';
    dio.options.headers['Authorization'] = '${AgentSamaWeb.authorization}';
    dio.options.headers['imei'] = '$imei';
    dio.options.headers['iduser'] = '$iduser';
    dio.options.headers['phone'] = '$phone';
    String dDeliv = dateDel!.replaceAll('/', '');

    String dExp = dateExp.replaceAll('/', '');
    String dNaiss = dateNaiss!.replaceAll('/', '');
    if (typePieceValue == 'CARTE D\'IDENTITÉ NATIONALE') {
      dExp = dDeliv;
    }

    if (typePieceValue == 'CARTE D\'IDENTITÉ NATIONALE') {
      typePieceInscript = "cin";
    } else if (typePieceValue == 'PASSEPORT') {
      typePieceInscript = "pass";
    } else {
      typePieceInscript = "";
    }

    String finalPhone = phoneNumber!.replaceAll(RegExp(r"\s\b|\b\s"), "");

    Map<String, String> bodyJson = HashMap();
    bodyJson['phoneAgent'] = '257$finalPhone';
    bodyJson['nom'] = '$nom';
    bodyJson['prenom'] = '$prenom';
    bodyJson['dNaissance'] = '$dNaiss';
    bodyJson['adrQuartier'] = '$quartier';
    bodyJson['adrVille'] = 'NC';
    bodyJson['cercle'] = 'NC';
    bodyJson['adrRegion'] = '$region';
    bodyJson['commune'] = '$commune';
    bodyJson['pays'] = 'ML';
    bodyJson['lieuDelivrance'] = '$lieuDeliv';
    bodyJson['lieuNaissance'] = '$lieuNaiss';

    bodyJson['typePiece'] = '$typePieceInscript';
    bodyJson['numPiece'] = '$numeroPiece';
    bodyJson['dDelivrance'] = '$dDeliv';
    bodyJson['dExpiration'] = '$dExp';
    bodyJson['login'] = '$login';
    bodyJson['loginpassword'] = '$pass';
    bodyJson['photo'] = '$base64Image';
    print(bodyJson);

    String result = await Services.httpPostRequest(dio, url, bodyJson);
    print(result);
    if (result == "error") {
      setState(() {
        _progressBarActive = false;
      });
      CustomDialogBox()
          .errorshowDialog(context, "Service momentanément indisponible.");
    } else {
      setState(() {
        _progressBarActive = false;
      });
      var data = json.decode(result);
      var sta = data["status"];
      var msg = data["msg"];
      var rslt = data["resultat"];

      if (sta == 0) {
        CustomDialogBox().onErrorAlertDialog(context, msg);
      } else {
        onSuccessAlertDialog(msg);
      }
    }
  }

  onSuccessAlertDialog(text) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: kSamaRougeDegradeColor,
            //  title: Text(title),
            content: Text(text,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                )),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Get.offNamedUntil(homePageRoute, (route) => false);
                },
                style: TextButton.styleFrom(
                  primary: Colors.transparent,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(colors: [
                        Color(0xFFFFFFFF),
                        Color(0xFFFFFFFF),
                        Color(0xFFFFFFFF),
                      ])),
                  child: const Center(
                    child: Text(
                      "Continuer",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: kSamaRougeDegradeColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}
