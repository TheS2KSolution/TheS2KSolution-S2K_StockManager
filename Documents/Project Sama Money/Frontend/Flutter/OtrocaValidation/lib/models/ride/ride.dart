import 'package:json_annotation/json_annotation.dart';
import 'package:sama/models/address/address.dart';
part 'ride.g.dart';

@JsonSerializable()
class Ride {
  int id;
  double price;
  Address departure;
  Address arrival;

  Ride(
    this.id,
    this.price,
    this.departure,
    this.arrival,
  );

  factory Ride.fromJson(Map<String, dynamic> json) => _$RideFromJson(json);

  /// Connect the generated [_$RideToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RideToJson(this);
}
