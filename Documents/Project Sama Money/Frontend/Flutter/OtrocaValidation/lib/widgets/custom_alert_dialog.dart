import 'package:flutter/material.dart';
import 'package:sama/utils/constants.dart';
import 'package:sama/utils/size_helpers.dart';

class CustomAlertDialog extends StatelessWidget {
  final String alertContentText;
  final IconData iconData;
  final Color circleColor;

  const CustomAlertDialog(
      {super.key,
      required this.alertContentText,
      required this.iconData,
      required this.circleColor});

  @override
  Widget build(BuildContext context) {
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
                        style: const TextStyle(
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
                // bottom: screenSize.width > 300 ?displayHeight(context) * 0.001: displayHeight(context) * 0.01,
                child: myCustomCircle(context, iconData, circleColor),
              ),
              // child: LayoutBuilder(
              //   builder: (context, constraints) {
              //     if (constraints.maxHeight > 260 && constraints.maxWidth > 578) {
              //       return myCustomCircle(context);
              //     }
              //     return myCustomCircle(context);
              //   },
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget myCustomCircle(
      BuildContext context, IconData myIcon, Color circleColor) {
    return Container(
      // height: displayHeight(context)*0.5,
      // width: displayWidth(context)*0.5,

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
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: circleColor),
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
}
