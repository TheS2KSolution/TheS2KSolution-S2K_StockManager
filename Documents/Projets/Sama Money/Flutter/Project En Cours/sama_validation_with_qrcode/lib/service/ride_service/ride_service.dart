import 'dart:convert';
// import 'package:sama/config/config.dart';
// import 'package:sama/models/channel/channel.dart';
import 'package:http/http.dart' as http;
import 'package:sama/config/config.dart';
import 'package:sama/models/ride/ride.dart';
import 'package:sama/models/ticket/ticket.dart';

class RideService {
  static Future<List<Ride>> findRides() async {
    var url = Uri.parse('${baseUrl}rides');
    http.Response response = await http.get(url, headers: headers);
    // print('${response.body}');
    List responseList = jsonDecode(response.body);
    List<Ride> rides = [];
    for (Map<String, dynamic> rideMap in responseList) {
      Ride ride = Ride.fromJson(rideMap);
      rides.add(ride);
    }
    return rides;
  }

  static Future<List<Ride>> findRideByUrbain() async {
    var url = Uri.parse('${baseUrl}rides?type=URBAIN');
    http.Response response = await http.get(url, headers: headers);
    // print('${response.body}');
    List responseList = jsonDecode(response.body);
    List<Ride> rideUrbain = [];
    for (Map<String, dynamic> rideMap in responseList) {
      Ride ride = Ride.fromJson(rideMap);
      rideUrbain.add(ride);
    }
    return rideUrbain;
  }

  static Future<List<Ride>> findRideByInterieur() async {
    var url = Uri.parse('${baseUrl}rides?type=INTERIEUR');
    http.Response response = await http.get(url, headers: headers);
    // print('${response.body}');
    List responseList = jsonDecode(response.body);
    List<Ride> rideInterieur = [];
    for (Map<String, dynamic> rideMap in responseList) {
      Ride ride = Ride.fromJson(rideMap);
      rideInterieur.add(ride);
    }
    return rideInterieur;
  }

  static buyTicket(Ticket ticket) async {
    Map data = {
      "price": ticket.price,
      "client": {"id": ticket.client.id},
      "ride": {"id": ticket.ride.id}
    };
    var body = json.encode(data);
    final url = Uri.parse('${baseUrl}tickets');
    http.Response response = await http.post(url, headers: headers, body: body);
    var resp = jsonDecode(response.body);
    return resp;
  }
}
