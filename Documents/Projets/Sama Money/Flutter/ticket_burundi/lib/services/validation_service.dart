import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ticket_burundi/models/ticket.dart';
import 'package:ticket_burundi/models/user.dart';
import 'package:ticket_burundi/models/user_save_result.dart';
import 'package:ticket_burundi/models/validation_result.dart';
import 'package:ticket_burundi/utilities/interceptor.dart';

class ValidationService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://ticketapi.sama.money/v2",
      connectTimeout: 10000,
      receiveTimeout: 5000,
    ),
  );

  Future<ValidationResult?> ticketValidation(Ticket ticket) async {
    try {
      Response response =
          await _dio.post("/samabu/ticket/validation", data: ticket.toJson());
      var value = jsonDecode(response.data);

      return ValidationResult.fromJson(value);
    } catch (e) {
      return ValidationResult(
          status: 2,
          msg:
              "Oupss!!!, problème au niveau du serveur.\n Veuillez contacter l'administrateur.\nMerci!!!");
    }
  }

  Future<UserSaveResult?> userRegistration(User user) async {
    try {
      Response response =
          await _dio.post("/samabu/ticket/user/infos", data: user.toJson());
      var value = jsonDecode(response.data);

      return UserSaveResult.fromJson(value);
    } catch (e) {
      return UserSaveResult(
          status: 2,
          msg:
              "Oupss!!!, problème au niveau du serveur.\n Veuillez contacter l'administrateur.\nMerci!!!");
    }
  }

  Future<UserSaveResult?> userRegistringVerification(String imei) async {
    try {
      Response response =
          await _dio.post("/samabu/ticket/user/valide", data: {"imei": imei});
      var value = jsonDecode(response.data);

      return UserSaveResult.fromJson(value);
    } catch (e) {
      return UserSaveResult(
          status: 2,
          msg:
              "Oupss!!!, problème au niveau du serveur.\n Veuillez contacter l'administrateur.\nMerci!!!");
    }
  }
}
