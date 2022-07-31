import 'package:dio/dio.dart';

abstract class ApiService {
  void init();

  Future<Response> getRequest();

  Future<Response> postRequest(dynamic data);
}

