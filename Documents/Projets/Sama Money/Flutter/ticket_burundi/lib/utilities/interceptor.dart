import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RequestInterceptor extends Interceptor {
  Future<void> getCircular() async {
    await CircularProgressIndicator();
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
        "=========================================================================");
    print(err);
    print(err.error);
    print(err.message);

    print(
        "=========================================================================");

    getCircular();
    super.onError(err, handler);
  }
}
