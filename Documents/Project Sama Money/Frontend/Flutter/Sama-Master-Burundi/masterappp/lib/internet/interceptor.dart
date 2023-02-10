import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("=============================");
    print("IN REQUEST INTERCEPTOR");
    print("=============================");

    EasyLoading.show(status: 'Patienter...');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("=============================");
    print("IN RESONSE INTERCEPTOR");
    print("=============================");
    EasyLoading.dismiss();
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print("=============================");
    print("IN ERROR INTERCEPTOR");
    print("=============================");
    EasyLoading.dismiss();
    super.onError(err, handler);
  }
}
