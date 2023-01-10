import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sama/models/vehicle/prepareVehicle.dart';
import 'package:sama/models/vehicle/vehicle.dart';
import 'package:sama/screen/qr_view.dart';
import 'package:sama/service/ticket_service/ticket_data.dart';
import 'package:sama/service/ticket_service/ticket_service.dart';
import 'package:sama/service/vehicle_service/vehicle_data.dart';
import 'package:sama/service/vehicle_service/vehicle_service.dart';
import 'package:sama/utils/constants.dart';
import 'package:sama/utils/size_helpers.dart';
import 'package:sama/widgets/custom_alert_dialog.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  static const color = const Color(0xff01224b);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController generatedCode = TextEditingController();
  TextEditingController vehiculeCode = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  bool _submitted = false;
  List<Vehicle> vehicles = [];
  //PrepareVehicle prepareVehicle = new PrepareVehicle();
  late Vehicle vehicle ;
  var rslt;


  findTicketByVehicle() async {
    vehicles = await VehicleService.findVehicle();
    Provider.of<VehicleData>(context, listen: false).vehicles = vehicles;
    setState(() {});
  }

  String? _errorText(TextEditingController controller, String formName) {
    final text = controller.value.text;
    if (text.isEmpty) {
      return 'Veuillez renseignez $formName';
    }

    if (text.isNotEmpty) {
      return null;
    }
  }

  @override
  void initState() {
    findTicketByVehicle();
    print(findTicketByVehicle());
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyHomePage.color,
        title: Text(
          "Retour à l'acueil",
        ),
      ),
      backgroundColor: mainBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                displayWidth(context) * 0.1,
                displayHeight(context) * 0.05,
                displayWidth(context) * 0.1,
                displayHeight(context) * 0.01,
              ),
              child: SvgPicture.string(
                svgSamaLogo,
                width: displayWidth(context) * 0.4,
              ),
            ),
            customTextFormField('Vehicle', 'Sélectionnez le Vehicule', true, () {
              showDialog(
                context: context,
                builder: (context) => vehicleDialog(context),
              );
            },
                vehiculeCode, context),
           customFormField(_formKey,generatedCode,'code du ticket',TextInputType.number,Icons.lock,"code ticket"),
            Container(
              margin: EdgeInsets.only(top: displayHeight(context) * 0.06),
              height: displayHeight(context) * 0.08,
              width: displayWidth(context) * 0.6,
              child: TextButton(
                onPressed: () async {
                  print("verification ");
                  if (_formKey.currentState!.validate() || _formKey2.currentState!.validate()  ) {
                    rslt = await TicketService.checkTicket(generatedCode.text);
                    print(rslt);
                    if (rslt['status'] == 1) {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => CustomAlertDialog(
                          alertContentText:
                          rslt['message'],
                          //"Echec:: Code ${generatedCode.text} incorrect",
                          iconData: Icons.check,
                          circleColor: Colors.green,
                        ),
                      );
                    } else if (rslt['status'] == 2){
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => CustomAlertDialog(
                          alertContentText:
                          rslt['message'],
                          //"Echec:: Code ${generatedCode.text} incorrect",
                          iconData: Icons.check,
                          circleColor: Colors.green,
                        ),
                      );
                    }else {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => CustomAlertDialog(
                          alertContentText:  rslt['message'],
                          iconData: Icons.dangerous,
                          circleColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: blueDegradeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'Verifier Ticket',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: displayWidth(context) * 0.06),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: displayHeight(context) * 0.06),
              height: displayHeight(context) * 0.08,
              width: displayWidth(context) * 0.6,
              child: TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() || _formKey2.currentState!.validate()  ) {
                    rslt = await VehicleService.buyTicket(generatedCode.text,vehicle);
                    print(rslt);
                    if (rslt['status'] == 1) {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => CustomAlertDialog(
                          alertContentText:
                          rslt['message'],
                              //"Echec:: Code ${generatedCode.text} incorrect",
                          iconData: Icons.check,
                          circleColor: Colors.green,
                        ),
                      );
                    } else {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => CustomAlertDialog(
                          alertContentText:  rslt['message'],
                          iconData: Icons.dangerous,
                          circleColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: blueDegradeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'Valider',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: displayWidth(context) * 0.06),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: displayHeight(context) * 0.06),
              height: displayHeight(context) * 0.08,
              width: displayWidth(context) * 0.9,
              child: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QrWiew(),
                      ));
                },
                style: TextButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  backgroundColor: blueDegradeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: Icon(
                  Icons.qr_code_scanner,
                  color: Colors.white,
                  size: displayWidth(context) * 0.1,
                ),
                label: Center(
                  child: Text(
                    'Scanner le QR code',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: displayWidth(context) * 0.06),
                  ),
                ),
              ),
            ),
         /*   Container(
              margin: EdgeInsets.only(top: displayHeight(context) * 0.02),
              height: displayHeight(context) * 0.08,
              width: displayWidth(context) * 0.9,
              child: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BuyTicketScreen(),
                      ));
                },
                style: TextButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  backgroundColor: blueDegradeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: Icon(
                  Icons.money,
                  color: Colors.white,
                  size: displayWidth(context) * 0.1,
                ),
                label: Center(
                  child: Text(
                    'Achat de ticket',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: displayWidth(context) * 0.06),
                  ),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
  Widget vehicleDialog(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.only(
        left: displayWidth(context) * 0.05,
        right: displayWidth(context) * 0.05,
        top: displayWidth(context) * 0.2,
        bottom: displayWidth(context) * 0.2,
      ),
      contentPadding: EdgeInsets.fromLTRB(
        displayWidth(context) * 0.03,
        displayHeight(context) * 0.01,
        displayWidth(context) * 0.03,
        displayHeight(context) * 0.01,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: displayHeight(context) * 0.4,
            width: displayWidth(context) * 0.9,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                      displayWidth(context) * 0.02,
                      displayWidth(context) * 0.02,
                      displayWidth(context) * 0.02,
                      displayWidth(context) * 0.02),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        vehiculeCode.text=  vehicles[index].immatriculation;
                        vehicle = vehicles[index];
                      });

                      Navigator.pop(context);
                    },
                    child: Text(
                     vehicles[index].immatriculation,
                      style: TextStyle(
                          color: Color.fromARGB(255, 6, 44, 75),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget myCustomAlertDialog(BuildContext context, String alertContentText,
      IconData myIcon, String errorType) {
    var screenSize = MediaQuery.of(context).size;
    return AlertDialog(
      // contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                  margin: EdgeInsets.only(top: displayHeight(context) * 0.05),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        alertContentText,
                        style: TextStyle(
                          color: mainBackgroundColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(top: displayHeight(context) * 0.02),
                        height: displayHeight(context) * 0.06,
                        width: displayWidth(context) * 0.8,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: mainBackgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Fermer',
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                    ],
                  )),
              Positioned(
                top: screenSize.width > 350
                    ? -displayHeight(context) * 0.2
                    : -displayHeight(context) * 0.19,
                child: myCustomCircle(context, myIcon, errorType),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget customFormField( Key key,_controller, hintText, TextInputType  keyBoardType, IconData icon, String FormName){
    return  Container(
      padding: EdgeInsets.fromLTRB(
        displayWidth(context) * 0.1,
        displayHeight(context) * 0.05,
        displayWidth(context) * 0.1,
        displayHeight(context) * 0.01,
      ),
      child: Form(
        key: key,
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Merci d'inserer le "+FormName;
            }
            return null;
          },
          style: TextStyle(height: displayHeight(context) * 0.002),
          keyboardType: keyBoardType,
          controller: _controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Color.fromARGB(255, 70, 69, 69),
            ),
            filled: true,
            prefixIcon: Icon(icon),
            fillColor: const Color.fromARGB(255, 255, 255, 255),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                style: BorderStyle.none,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                style: BorderStyle.none,
              ),
            ),
          ),
        ),
      ),
    );

  }

  Widget myCustomCircle(
      BuildContext context, IconData myIcon, String errorType) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            width: displayWidth(context) * 0.23,
            height: displayHeight(context) * 0.3,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          Container(
            width: displayWidth(context) * 0.2,
            height: displayHeight(context) * 0.2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: errorType == 'warning'
                  ? Color.fromARGB(255, 248, 198, 34)
                  : Color.fromARGB(255, 244, 20, 20),
            ),
            child: Icon(
              myIcon,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
  Widget customTextFormField(formName, labelText, readRight, selectOption,
      field, BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        displayWidth(context) * 0.1,
        displayHeight(context) * 0.05,
        displayWidth(context) * 0.1,
        displayHeight(context) * 0.01,
      ),
      child: TextFormField(
        onChanged: (value) {
          // labelText == "Numéro de la carte"
          //     ? setState(() {
          //         subsc.cardNumber = value;
          //         print(cardNumber.text);
          //       })
          //     : null;
        },
        keyboardType:
        formName == 'le numéro' ? TextInputType.number : TextInputType.text,
        style: TextStyle(height: displayHeight(context) * 0.002),
        controller: field,
        onTap: selectOption,
        readOnly: readRight,
        decoration: InputDecoration(
          errorText: _submitted == false ? null : _errorText(field, formName),
          suffixIcon: labelText == 'Numéro du Vehicule'
              ? null
              : Icon(
            Icons.arrow_drop_down,
            color: Colors.red,
          ),
          filled: true,
          /*contentPadding: EdgeInsets.symmetric(
            vertical: 0.0,
            horizontal: displayWidth(context) * 0.02,
          ),*/
          hintText: labelText.toString(),
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              style: BorderStyle.none,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              style: BorderStyle.none,
            ),
          ),
        ),
      ),
    );
  }


}
