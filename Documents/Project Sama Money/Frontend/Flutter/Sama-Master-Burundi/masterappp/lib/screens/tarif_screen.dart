import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:masterappp/constants/constants.dart';
import 'package:masterappp/routes/route_constants.dart';
import 'package:masterappp/widgets/custom_app_bar.dart';
import 'package:masterappp/widgets/custom_drawer.dart';
import 'package:masterappp/widgets/custom_header_text.dart';


class TarifScreen extends StatefulWidget {
  const TarifScreen({Key? key}) : super(key: key);

  @override
  _TarifScreenState createState() => _TarifScreenState();
}

class _TarifScreenState extends State<TarifScreen> {
  goToNextPage(int i) {
    switch (i) {
      case 0:
        {
          Get.toNamed(samaFraisServicePageRoute);
        }
        break;

      case 1:
        {
          Get.toNamed(canalTarifPageRoute);
        }
        break;

      case 2:
        {
          Get.toNamed(starTimesTarifPageRoute);
        }
        break;
      case 3:
        {
          //  Navigator.pushNamed(context, MalivisionTarifScreenRoute);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Choice> choices = const <Choice>[
      Choice(
          title: "Frais de retrait cash (depuis le compte Principal)",
          icon: 'images/frais.svg'),
      Choice(title: "Bouquet Canal +", icon: 'images/frais.svg'),
      Choice(title: "Bouquet StarTimes", icon: 'images/frais.svg'),
      // const Choice(title: 'Bouquet Malivision', icon: 'images/frais.svg'),
    ];
    return Container(
      decoration: kBackGroundDecoration,
      child: Scaffold(
          appBar: MyAppBar(),
          backgroundColor: Colors.transparent,
          drawer: MyDrawer(),
          //  bottomNavigationBar: MyHomeBottomNavBar(),
          body: getBody(choices)),
    );
  }

  Widget getBody(List<Choice> choices) => Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: ListView(physics: ClampingScrollPhysics(), children: <Widget>[
          CustomHeaderText(
            text: "Frais des services",
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Center(
            child: Text(
              "Les frais de retrait cash depuis le compte Bourse/Salaire sont 100% gratuits.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                // fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            child: ListView.builder(
              itemCount: choices.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 3.0, top: 3.0),
                    child: ChoiceCard(
                      choice: choices[index],
                      onTap: () {
                        goToNextPage(index);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ]),
      );
}

class Choice {
  const Choice({this.title, this.icon});

  final String? title;
  final String? icon;
}

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key? key, this.choice, this.onTap}) : super(key: key);
  final Choice? choice;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Color colo = Color(0xFF01224b);
    return Card(
      color: Colors.white,
      child: ListTile(
        onTap: onTap,
        leading: SvgPicture.asset(
          choice!.icon!,
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.05,
        ),
        title: Text(
          choice!.title!,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
