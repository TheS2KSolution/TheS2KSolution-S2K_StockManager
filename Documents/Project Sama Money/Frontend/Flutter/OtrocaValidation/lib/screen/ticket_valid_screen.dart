import 'package:flutter/material.dart';
import 'package:sama/models/client/client.dart';
import 'package:sama/models/ride/ride.dart';
import 'package:sama/models/ticket/prepareTicket.dart';
import 'package:sama/models/ticket/ticket.dart';
import 'package:sama/screen/buy_ticket.dart';
import 'package:sama/screen/choose.dart';
import 'package:sama/screen/constants.dart';
import 'package:sama/service/ride_service/ride_service.dart';
import 'package:sama/widgets/custom_header_text.dart';
import 'package:sama/widgets/envoyer_button.dart';

class TicketValidScreen extends StatefulWidget {
  final PrepareTicket? prepareTicket;
  final Ride? ride;

  const TicketValidScreen(
      {Key? key, required this.prepareTicket, required this.ride})
      : super(key: key);

  @override
  State<TicketValidScreen> createState() => _TicketValidScreenState();
}

class _TicketValidScreenState extends State<TicketValidScreen> {
  late Ticket myTicket;
  var rslt;
  TextEditingController myPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  TextStyle style = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextStyle styleTitle = const TextStyle(
      fontSize: 20, color: Color(0xFF01224b), fontWeight: FontWeight.bold);

  final formKeyAlert = GlobalKey<FormState>();
  String messageText = '';
  String password = '';
  String numeroTicket = '';

  Widget getBody() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const CustomHeaderText(
            text: 'Achat ticket',
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Center(
              child: Text(
                messageText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFFD61A0E),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Table(columnWidths: const {
            0: FractionColumnWidth(0.0),
            1: FixedColumnWidth(0.0)
          }, children: [
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Depart :', style: style),
              ),
              Padding(
                //padding: const EdgeInsets.symmetric(vertical: 8.0),
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(widget.prepareTicket!.getDeparture.name,
                    style: styleTitle, textAlign: TextAlign.center),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Arrivé :',
                  style: style,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(widget.prepareTicket!.getArrival.name,
                    style: styleTitle, textAlign: TextAlign.center),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Type de Voyage :',
                  style: style,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(widget.prepareTicket!.getDeparture.type,
                    style: styleTitle, textAlign: TextAlign.center),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Montant :',
                  style: style,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                    widget.prepareTicket!.getPrice.toInt().toString() + ' FBu',
                    style: styleTitle,
                    textAlign: TextAlign.center),
              ),
            ]),
          ]),
          const SizedBox(
            height: 40.0,
          ),
          EnvoyerButton(
            title: 'Envoyer',
            onPressed: _submitCommand,
          ),
          const SizedBox(
            height: 40.0,
          ),
        ],
      ));

  void _submitCommand() {
    showCustomDialogWithImage(
      context,
    );
  }

  void _succesTicketBuy() {
    onSuccessAlertDialog(
      context,
    );
  }

  void _ErrorPassword() {
    ErorAlertDialog(
      context,
    );
  }

  void showCustomDialogWithImage(
    BuildContext context,
  ) {
    Dialog dialogWithImage = Dialog(
      backgroundColor: Colors.transparent,
      child: SizedBox(
        height: 430.0,
        width: 300.0,
        child: Form(
          //key: formKeyAlert,
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                      color: Color(0xFF01224b)),
                  child: const SizedBox(
                    width: 300,
                    height: 60,
                    child: Icon(
                      Icons.message,
                      color: Colors.white,
                      size: 35.0,
                    ),
                  )),
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                    color: Colors.white),
                child: Column(children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        'ATTENTION\n'
                        'Une fois exécuté, cet achat n\'est ni annulable, ni remboursable.',
                        style: TextStyle(
                            color: Color(0xFFd61a0e),
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Container(
                    height: 80.0,
                    width: 300.0,
                    padding: const EdgeInsets.only(
                        left: 15.0, top: 00.0, right: 15.0),
                    child: Text(
                      'Vous allez recharger le ticket pour ' +
                          widget.prepareTicket!.getDeparture.name +
                          ' - ' +
                          widget.prepareTicket!.getArrival.name +
                          '. Veuillez saisir votre mot de passe pour continuer.',
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                      width: 300,
                      padding: const EdgeInsets.only(
                          left: 15.0, top: 0.0, right: 15.0),
                      child: Container(
                        //height: 30,
                        padding: kTextFieldContainerPaddingPassword,
                        decoration: kTextFieldContainerBoxDecoration,
                        child: TextFormField(
                          decoration: kTextFieldDecorationPassword.copyWith(
                              hintText: 'Entrez votre mot de passe '),
                          textAlign: TextAlign.start,
                          autofocus: false,
                          enabled: true,
                          maxLines: 1,
                          obscureText: true,
                          controller: myPassword,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          onChanged: (String value) {
                            setState(() {
                              password = value;
                            });
                          },
                          style: kTextFieldStylePassword,
                        ),
                      )),
                  Container(
                    width: 300.0,
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Center(
                            child: Text(
                              "Annuler",
                              style: TextStyle(
                                  color: Color(0xFF01224b),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: () async {
                            if (myPassword.text == "123456") {
                              Ticket myTicket =
                                  Ticket(1, 1000, Client(1), widget.ride!);
                              rslt = await RideService.buyTicket(myTicket);
                              print(rslt);
                              _succesTicketBuy();
                            } else {
                              _ErrorPassword();
                              myPassword.clear();
                            }
                          },
                          //color: Colors.transparent,
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
                                'valider',
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
                  Visibility(
                    // visible: _isFingerPrintVisible,
                    child: SizedBox(
                      width: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Divider(
                              height: 5.0,
                              thickness: 3.0,
                              color: Color(0xFF01224b),
                            ),
                          ),
                          const Center(
                            child: Text(
                              'Continuer avec l\'empreinte digitale',
                              style: TextStyle(
                                  color: Color(0xFF01224b), fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _succesTicketBuy;
                              //_authenticateUser();
                            },
                            icon: const Icon(
                              Icons.fingerprint,
                              size: 40,
                              color: Color(0xFF01224b),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => dialogWithImage);
  }

  onSuccessAlertDialog(text) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color(0xFF01224b),
            //  title: Text(title),
            content: Text(rslt['message'] +rslt['body']['code'],
                style: const TextStyle(fontSize: 16.0, color: Colors.white)),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChooseSceen()),
                  );
                },
                // color: Colors.transparent,
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
                      'Continuer',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF01224b),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  ErorAlertDialog(text) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.red,
            //  title: Text(title),
            content: const Text('mot de passe incorrect',
                style: TextStyle(fontSize: 16.0, color: Colors.white)),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                // color: Colors.transparent,
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
                      'OK',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.red,
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
