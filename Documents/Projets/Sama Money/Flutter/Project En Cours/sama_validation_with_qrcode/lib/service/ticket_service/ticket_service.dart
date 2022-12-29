import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sama/config/config.dart';
import 'package:sama/models/ticket/ticket.dart';
import 'package:sama/models/vehicle/vehicle.dart';

class TicketService {

  static buyTicket(  code,  vehicle) async {
    Map data = {
      "code": code,
      "vehicle": vehicle,
    };
    var body = json.encode(data);
    final url = Uri.parse('${baseUrl}tickets/valid');
    http.Response response = await http.post(url, headers: headers, body: body);
    var resp = jsonDecode(response.body);
    return resp;
  }
}