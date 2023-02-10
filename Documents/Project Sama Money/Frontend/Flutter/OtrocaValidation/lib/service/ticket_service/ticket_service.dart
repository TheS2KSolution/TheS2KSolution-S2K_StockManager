import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sama/config/config.dart';


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


  static checkTicket(code) async {
    final url = Uri.parse('${baseUrl}tickets/verification?code=$code');
    http.Response response = await http.get(url, headers: headers, );
    var resp = jsonDecode(response.body);
    return resp;
  }
}
