

import 'package:json_annotation/json_annotation.dart';



@JsonSerializable()
class PrepareVehicle {
  late int id;
   late String immatriculation;
  late int nbrSeat;




  int get getId {
    return id;
  }

  String get getImmatriculation{
    return immatriculation;
  }

  int get getNbreSeat {
    return nbrSeat;
  }


  set setId(int id) {
    this.id = id;
  }

  set setImmatriculation(String immatriculation) {
    this.immatriculation = immatriculation;
  }



  set setRide(int nbrSeat) {
    this.nbrSeat = nbrSeat;
  }


}
