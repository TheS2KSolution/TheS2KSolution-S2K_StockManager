import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sama/config/config.dart';
import 'package:sama/models/ticket/ticket.dart';
import 'package:sama/models/vehicle/vehicle.dart';

class VehicleService {


  static Future<List<Vehicle>> findVehicle() async {
    var url = Uri.parse('${baseUrl}vehicles');
    http.Response response = await http.get(url, headers: headers);
    var responseList = jsonDecode(response.body);
   // print(responseList);
    List<Vehicle> vehicles = [];
    for (Map<String, dynamic> VehicleMap in responseList['content']) {
      Vehicle vehicle = Vehicle.fromJson(VehicleMap);
      vehicles.add(vehicle);
    }
    return vehicles;
  }



  static buyTicket(code,vehicle) async {
    Map data = {
      "code": code,
      "vehicle": vehicle,
    };
    var body = json.encode(data);
    final url = Uri.parse('${baseUrl}tickets/valid');
    http.Response response = await http.post(url, headers: headers, body: body);
    var resp = jsonDecode(response.body);
    print(resp);
    return resp;
  }
}
