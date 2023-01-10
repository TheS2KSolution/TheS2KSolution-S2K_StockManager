import 'package:sama/models/address/address.dart';

class PrepareTicket {
  Address? departure;
  Address? arrival;
  double? price;
  String? type;

  // Subscription(this.duration, this.bouquet, this.option, this.cardNumber);

  Address get getDeparture {
    return departure!;
  }

  Address get getArrival {
    return arrival!;
  }

  double get getPrice {
    return price!;
  }

  String get getType {
    return type!;
  }

  set setDeparture(Address depart) {
    this.departure = depart;
  }

  set setArrival(Address arrivee) {
    this.arrival = arrivee;
  }

  set setPrice(double price) {
    this.price = price;
  }

  set setType(String type) {
    this.type = type;
  }
}
