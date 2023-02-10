import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomCircularProgresssDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: SpinKitFadingCircle(color: Colors.white),
            ),
            SizedBox(
              width: 5.0,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Chargement.. Patientez...",
                style: TextStyle(fontSize: 13, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
