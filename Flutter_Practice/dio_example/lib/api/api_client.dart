import 'package:dio/dio.dart';
import 'package:dio_example/api/api_service.dart';
import 'package:dio_example/api/end_points.dart';

class ApiClient implements ApiService{
  static late Dio _dio;
  ApiClient.initialize();
  static final ApiClient _instance = ApiClient.initialize();

  factory ApiClient(){
    return _instance;
  }

  @override
  void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        connectTimeout: 5000,
        receiveTimeout: 3000
      )
    )..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  @override
  Future<Response> getRequest() async {
    var response = await _dio.get(EndPoints.posts);
    return response;
  }

  @override
  Future<Response> postRequest(data) {
    // TODO: implement postRequest
    throw UnimplementedError();
  }
}