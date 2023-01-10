import 'package:json_annotation/json_annotation.dart';
import 'package:sama/models/client/client.dart';
import 'package:sama/models/ride/ride.dart';

part 'ticket.g.dart';

@JsonSerializable()
class Ticket {
  int id;
  double price;
  Client client;
  Ride ride;

  Ticket(
    this.id,
    this.price,
    this.client,
    this.ride,
  );

  int get  getId{
    return id;
  }

  double get getPrice {
    return price;
  }

  Client get getCLient {
    return client;
  }

  Ride get getRide {
    return ride;
  }

  set setId(int id) {
    this.id = id;
  }

  set setPrice(double price) {
    this.price = price;
  }

  set setClient(int id) {
    this.client.id = client.id;
  }

  set setRide(Ride ride) {
    this.ride = ride;
  }

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  /// Connect the generated [_$TicketToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TicketToJson(this);
}
