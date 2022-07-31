import 'package:http/http.dart';

abstract class ApiService {
  Future<Response> getRequest({required String endPoint});
}