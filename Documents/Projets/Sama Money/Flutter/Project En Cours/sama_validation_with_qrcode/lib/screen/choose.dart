import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sama/screen/buy_ticket.dart';
import 'package:sama/screen/myHomePage.dart';
import 'package:sama/utils/constants.dart';
import 'package:sama/utils/size_helpers.dart';

class ChooseSceen extends StatefulWidget {
  const ChooseSceen({Key? key}) : super(key: key);

  @override
  State<ChooseSceen> createState() => _ChooseSceenState();
}

class _ChooseSceenState extends State<ChooseSceen> {
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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: displayHeight(context) * 0.07),
                child: SvgPicture.string(
                  svgSamaLogo,
                  width: displayWidth(context) * 0.4,
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: displayHeight(context) * 0.2),
                height: displayHeight(context) * 0.08,
                width: displayWidth(context) * 0.6,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyHomePage(),
                        ));
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: blueDegradeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Validation ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: displayWidth(context) * 0.06),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: displayHeight(context) * 0.1),
                height: displayHeight(context) * 0.08,
                width: displayWidth(context) * 0.6,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BuyTicketScreen(),
                        ));
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: blueDegradeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Achat ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: displayWidth(context) * 0.06),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
