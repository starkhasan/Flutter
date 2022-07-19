import '../../networks/api/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiClient implements ApiService {

  static const header = {
    'Cache-Control': 'no-cache'
  };

  @override
  Future<Response> getRequest({required String endPoint}) async {
    var response = await http.get(Uri.parse(endPoint));
    return response;
  }

}