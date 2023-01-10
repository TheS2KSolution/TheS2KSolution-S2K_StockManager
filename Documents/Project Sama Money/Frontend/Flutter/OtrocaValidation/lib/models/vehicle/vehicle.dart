

import 'package:json_annotation/json_annotation.dart';

part 'vehicle.g.dart';

@JsonSerializable()
class Vehicle {
  int id;
  String immatriculation;
  int nbrSeat;


  Vehicle(
      this.id,
      this.immatriculation,
      this.nbrSeat,
      );

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

  factory Vehicle.fromJson(Map<String, dynamic> json) => _$VehicleFromJson(json);

  /// Connect the generated [_$TicketToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}
