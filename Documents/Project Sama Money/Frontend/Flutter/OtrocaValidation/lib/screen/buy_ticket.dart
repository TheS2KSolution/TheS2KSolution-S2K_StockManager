import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sama/models/ride/ride.dart';
import 'package:sama/models/ticket/prepareTicket.dart';
import 'package:sama/screen/ticket_valid_screen.dart';
import 'package:sama/service/ride_service/ride_data.dart';
import 'package:sama/service/ride_service/ride_service.dart';
import 'package:sama/utils/size_helpers.dart';

class BuyTicketScreen extends StatelessWidget {
  const BuyTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BuyTicketWidget(),
    );
  }
}

class BuyTicketWidget extends StatefulWidget {
  const BuyTicketWidget({super.key});

  @override
  State<BuyTicketWidget> createState() => _BuyTicketWidgetState();
}

class _BuyTicketWidgetState extends State<BuyTicketWidget> {
  bool _submitted = false;
  TextEditingController trajetSelect = TextEditingController();
  TextEditingController typSelect = TextEditingController();

  // TextEditingController arriveeSelect = TextEditingController();
  PrepareTicket prepareTicket = PrepareTicket();
  late Ride myRide;

  List<Ride>? rides;
  List<Ride>? rideInterieur;
  List<Ride>? rideUrbain;
  List<Map<String, dynamic>> selectType = [
    {'libelle': 'URBAIN'},
    {'libelle': 'INTERIEUR'}
  ];

  findAddress() async {
    rides = await RideService.findRides();
    Provider.of<RideData>(context, listen: false).rides = rides!;
    setState(() {});
  }

  findByUrabin() async {
    rideUrbain = await RideService.findRideByUrbain();
    Provider.of<RideData>(context, listen: false).rideUrbain = rideUrbain!;
    setState(() {});
  }

  findByInterieur() async {
    rideInterieur = await RideService.findRideByInterieur();
    Provider.of<RideData>(context, listen: false).rideInterieur =
        rideInterieur!;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // findAddress();
    findByInterieur();
    findByUrabin();
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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: displayHeight(context) * 0.1,
          ),
          Container(
            // alignment: Alignment.center,
            // child: Text(
            //   'Achat ticket'
            //   // \nOTRACO'
            //   ,
            //   style: TextStyle(fontSize: displayWidth(context) * 0.075),
            // ),
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 36),
                  children: <TextSpan>[
                    TextSpan(
                        text: "Achat ticket",
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Avenir Next LTPro',
                            fontSize: 24)),
                    // TextSpan(
                    //     text: '(OTRACO)',
                    //     style: TextStyle(
                    //         color: Colors.black54,
                    //         fontFamily: 'Avenir Next LTPro',
                    //         fontSize: 18)),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 70.0,
            //height: displayHeight(context) * 0.02,
          ),
          customTextFormField('Type', 'Sélectionnez votre Type', true, () {
            showDialog(
              context: context,
              builder: (context) => TypeDialog(context),
            );
          }, typSelect, context),
          SizedBox(
            height: displayHeight(context) * 0.02,
          ),
          customTextFormField('Depart', 'Sélectionnez votre trajet', true, () {
            showDialog(
              context: context,
              builder: (context) => departDialog(context),
            );
          }, trajetSelect, context),

          SizedBox(
            height: displayWidth(context) * 0.1,
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.fromLTRB(
                displayWidth(context) * 0.2,
                displayHeight(context) * 0.02,
                displayWidth(context) * 0.2,
                displayHeight(context) * 0.02,
              ),
              backgroundColor: const Color.fromARGB(255, 5, 38, 105),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(style: BorderStyle.none),
              ),
            ),
            onPressed: () {
              if (trajetSelect.text.isEmpty) {
                setState(() {
                  _submitted = true;
                });
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TicketValidScreen(
                      prepareTicket: prepareTicket,
                      ride: myRide,
                    ),
                  ),
                );
              }
            },
            child: const Text(
              'Continuer',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
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
        displayWidth(context) * 0.02,
        displayHeight(context) * 0,
        displayWidth(context) * 0.02,
        displayHeight(context) * 0.02,
      ),
      child: TextFormField(
        onChanged: (value) {

        },
        keyboardType:
            formName == '' ? TextInputType.number : TextInputType.text,
        style: const TextStyle(
            color: Color.fromARGB(255, 5, 38, 105),
            fontWeight: FontWeight.bold),
        controller: field,
        onTap: selectOption,
        readOnly: readRight,
        decoration: InputDecoration(
          errorText: _submitted == false ? null : _errorText(field, formName),
          suffixIcon: labelText == ''
              ? null
              : Icon(
                  Icons.arrow_drop_down,
                  color: Colors.red,
                ),
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 0.0,
            horizontal: displayWidth(context) * 0.02,
          ),
          hintText: labelText.toString(),
          fillColor: const Color.fromARGB(255, 230, 238, 245),
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

  Widget departDialog(BuildContext context) {
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
      content: Consumer<RideData>(
        builder: (context, value, child) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: displayHeight(context) * 0.4,
              width: displayWidth(context) * 0.9,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: value.rides.length,
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
                          myRide = value.rides[index];
                          trajetSelect.text =
                              value.rides[index].departure.name +
                                  ' - ' +
                                  value.rides[index].arrival.name;
                          prepareTicket.arrival = value.rides[index].arrival;
                          prepareTicket.departure =
                              value.rides[index].departure;
                          prepareTicket.price = value.rides[index].price;
                          // print(prepareTicket);
                        });
                        // var channelId = value.channels[index].id;
                        Navigator.pop(context);
                      },
                      child: Text(
                        '${value.rides[index].departure.name + ' - ' + value.rides[index].arrival.name + ' (' + value.rides[index].price.toString() + ' FBu)'}',
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
      ),
    );
  }

  Widget TypeDialog(BuildContext context) {
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
              itemCount: selectType.length,
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
                        typSelect.text = selectType[index]["libelle"];
                        Provider.of<RideData>(context, listen: false)
                            .chooseRideType(typSelect.text);
                        // print(prepareTicket);
                      });
                      // var channelId = value.channels[index].id;
                      Navigator.pop(context);
                    },
                    child: Text(
                      '${selectType[index]["libelle"]}',
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
}
