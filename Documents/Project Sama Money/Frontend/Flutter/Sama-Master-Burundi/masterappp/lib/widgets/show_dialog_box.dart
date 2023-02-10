import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDialogBox {
  errorshowDialog(BuildContext context, text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // title: Text(title),
            content: Text(text),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "OK",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  noInternetSimpleshowDialog(BuildContext context, title, text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  twoFieldIncorrectshowDialog(BuildContext context, text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // title: Text(title),
            content: Text(text),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "OK",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  basculerToOfflineDialog(BuildContext context) {
    Dialog dialogWithImage = Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 300.0,
        width: 300.0,
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                    color: Color(0xFF01224b)),
                child: Container(
                    width: 300,
                    height: 35,
                    child: const Center(
                      child: Text(
                        'Pas de connexion internet',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.white),
                      ),
                    ))),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0)),
                  color: Colors.white),
              child: Column(children: <Widget>[
                Container(
                  height: 100.0,
                  width: 300.0,
                  padding:
                      const EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0),
                  child: const Text(
                    'Si vous voulez basculer sur la version OffLine appuyez sur Oui, dans le cas contraire appuyer sur Non pour rester sur la version Online.',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
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
                        child: Container(
                          child: const Center(
                            child: Text(
                              "Non",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Color(0xFF01224b),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style:
                            TextButton.styleFrom(primary: Colors.transparent),
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
                              'Oui',
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
              ]),
            ),
          ]),
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => dialogWithImage);
  }

  onErrorAlertDialog(BuildContext context, text) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color(0xFFD61A0E),
            content: Text(text,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                )),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(primary: Colors.transparent),
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
                      "OK",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFFD61A0E),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  showVersionDialog(context) {
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "Nouvelle mise à jour disponible";
        String message =
            "Une nouvelle version de l'application est disponible, veuillez la mettre à jour maintenant.";
        String btnLabel = "Mettez à jour maintenant";
        String btnLabelCancel = "Plus tard";
        return Platform.isIOS
            ? CupertinoAlertDialog(
                title: Text(
                  title,
                  style: const TextStyle(
                      color: Color(0xFFd61a0e),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                content: Text(
                  message,
                  style: const TextStyle(
                      color: Color(0xFF01224b),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                actions: <Widget>[
                  TextButton(child: Text(btnLabel), onPressed: () {}),
                  TextButton(
                    child: Text(btnLabelCancel),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              )
            : AlertDialog(
                title: Text(
                  title,
                  style: const TextStyle(
                      color: Color(0xFFd61a0e),
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                content: Text(
                  message,
                  style: const TextStyle(
                    color: Color(0xFF01224b),
                    fontSize: 14,
                    // fontWeight: FontWeight.w600
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                      child: Text(btnLabel,
                          style: const TextStyle(
                            color: Color(0xFF01224b),
                            fontSize: 16,
                          )),
                      onPressed: () async {
                        print('Yes');
                        //    Navigator.pop(context);
                        SystemNavigator.pop();
                        String PLAY_STORE_URL =
                            'https://play.google.com/store/apps/details?id=sama.money.samaweb';
                        //   _launchURL(PLAY_STORE_URL);
                        SystemNavigator.pop();
                      }),
                  TextButton(
                    child: Text(btnLabelCancel,
                        style: const TextStyle(
                          color: Color(0xFFd61a0e),
                          fontSize: 16,
                        )),
                    onPressed: () => SystemNavigator.pop(),
                    //Navigator.pop(context),
                  ),
                ],
              );
      },
    );
  }
}
