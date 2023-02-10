import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:masterappp/constants/constants.dart';
import 'package:masterappp/constants/important_text_constant.dart';
import 'package:masterappp/widgets/custom_app_bar.dart';
import 'package:masterappp/widgets/custom_drawer.dart';
import 'package:masterappp/widgets/custom_header_text.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ReclamationScreen extends StatefulWidget {
  @override
  _ReclamationScreenState createState() => _ReclamationScreenState();
}

class _ReclamationScreenState extends State<ReclamationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBackGroundDecoration,
      child: Scaffold(
          appBar: MyAppBar(),
          backgroundColor: Colors.transparent,
          drawer: MyDrawer(),
          // bottomNavigationBar: MyHomeBottomNavBar(),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: <Widget>[
                CustomHeaderText(
                  text: "Contacts",
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL('https://wa.me/25767620000?text=Salut%20Sama');
                  },
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: const [
                                Icon(
                                  FontAwesomeIcons.whatsapp,
                                  color: Color(0xFF47b649),
                                  size: 30.0,
                                ),
                                Text(
                                  "Ecrivez-nous sur WhatsApp",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: kSamaBleuColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            FontAwesomeIcons.check,
                            color: Color(0xFF01224b),
                            size: 15.0,
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL('tel:+223 22 28 12 41');
                  },
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: const [
                                    Icon(
                                      FontAwesomeIcons.phoneSquare,
                                      color: Color(0xFF01224b),
                                      size: 30.0,
                                    ),
                                    Text(
                                      "Appelez-nous",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: kSamaBleuColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const Text(
                                    "Horaires: Lundi au Samedi 8h a 23h.")
                              ],
                            ),
                          ),
                          const Icon(
                            FontAwesomeIcons.check,
                            color: Color(0xFF01224b),
                            size: 15.0,
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL(
                        'mailto:reception.bi@sama.money?subject=Information&body=');
                  },
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: const [
                                Icon(
                                  FontAwesomeIcons.envelopeOpenText,
                                  color: Color(0xFFED9721),
                                  size: 30.0,
                                ),
                                Text(
                                  "Envoyez-nous un Mail",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: kSamaBleuColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            FontAwesomeIcons.check,
                            color: Color(0xFF01224b),
                            size: 15.0,
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL('http://m.me/samaburundi');
                  },
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: const [
                                Icon(
                                  FontAwesomeIcons.facebookMessenger,
                                  color: Color(0xFF59B1F6),
                                  size: 30.0,
                                ),
                                Text(
                                  "Ecrivez-nous sur Messenger",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: kSamaBleuColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            FontAwesomeIcons.check,
                            color: Color(0xFF01224b),
                            size: 15.0,
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL('https://sama.money');
                  },
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: const [
                                Icon(
                                  FontAwesomeIcons.globe,
                                  color: Color(0xFF01224b),
                                  size: 30.0,
                                ),
                                Text(
                                  "Visitez notre Site web",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: kSamaBleuColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            FontAwesomeIcons.check,
                            color: Color(0xFF01224b),
                            size: 15.0,
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  _launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
