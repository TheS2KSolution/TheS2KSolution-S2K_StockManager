import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:masterappp/constants/constants.dart';
import 'package:masterappp/models/agent_model.dart';
import 'package:masterappp/models/histo_principale_model.dart';

class Services {
  static Future<String> httpPostRequest(
      Dio dio, String url, Map<String, String> formData) async {
    // dio.interceptors.add(RequestInterceptor());
    try {
      // add the parameters to pass to the request.
      Response response;
      response = await dio.post("${urlLink}$url", data: formData);

      if (200 == response.statusCode) {
        return response.data.toString();
      } else {
        return "error";
      }
    } catch (e) {
      print(e.toString());
      return "error";
    }
  }

  static Future<List<HistoPrincipalModel>> histoPrincipal(
      {Dio? dio, String? url, Map<String, String>? formData}) async {
    // dio!.interceptors.add(RequestInterceptor());
    Response response;
    response = await dio!.post("${urlLink}$url", data: formData!);

    if (response.statusCode == 200) {
      String content = response.data.toString();
      // print(content);
      var dataItem = json.decode(content);
      List? collection = dataItem["resultat"];
      Iterable<HistoPrincipalModel> _contacts =
          collection!.map((json) => HistoPrincipalModel.fromJson(json));
      // print(_contacts.toList());
      return _contacts.toList();
    } else {
      print('zero');
    }
    throw "";
  }

  static Future<List<AgentModel>> historiqueAgent(
      {Dio? dio, String? url, Map<String, String>? formData}) async {
    // dio!.interceptors.add(RequestInterceptor());
    Response response;
    response = await dio!.post("${urlLink}$url", data: formData);

    if (response.statusCode == 200) {
      String content = response.data.toString();
      //print(content);
      var dataItem = await json.decode(content);
      // print(dataItem);
      List collection = await dataItem["resultat"];
      Iterable<AgentModel> _contacts =
          await collection.map((json) => AgentModel.fromJson(json));
      // print(_contacts.toList());
      return _contacts.toList();
    } else {
      print('zero');
    }
    throw "";
  }
}
