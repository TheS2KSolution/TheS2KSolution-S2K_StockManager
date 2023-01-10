import 'package:flutter/cupertino.dart';
import 'package:sama/models/ride/ride.dart';

class RideData extends ChangeNotifier {
  List<Ride> rides = [];
  List<Ride> rideUrbain = [];
  List<Ride> rideInterieur = [];

  chooseRideType(libelle) {
    if (libelle == "URBAIN") {
      rides = rideUrbain;
    } else {
      rides = rideInterieur;
    }
    notifyListeners();
  }
}
