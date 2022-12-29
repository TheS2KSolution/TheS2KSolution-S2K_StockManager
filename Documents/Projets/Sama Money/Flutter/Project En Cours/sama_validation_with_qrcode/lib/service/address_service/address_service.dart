import 'dart:convert';
// import 'package:sama/config/config.dart';
// import 'package:sama/models/channel/channel.dart';
import 'package:http/http.dart' as http;
import 'package:sama/config/config.dart';
import 'package:sama/models/address/address.dart';

class AddressService {
  static Future<List<Address>> findAddress() async {
    var url = Uri.parse('${baseUrl}addresses?type=urbain');
    http.Response response = await http.get(url, headers: headers);
    print('${response.body}');
    List responseList = jsonDecode(response.body);
    List<Address> addreses = [];
    for (Map<String, dynamic> addressMap in responseList) {
      Address address = Address.fromJson(addressMap);
      addreses.add(address);
    }
    return addreses;
  }
}
