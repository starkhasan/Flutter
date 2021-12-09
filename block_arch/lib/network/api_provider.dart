import 'dart:convert';
import 'package:block_arch/models/weather_response.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  final Uri baseURL = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=Arrah&appid=e661b5089b025ac13a439a48b73ae5cf");

  Future<WeatherResponse> weatherDetails() async {
    try {
      var response = await http.get(baseURL);
      if (response.statusCode == 200) {
        return WeatherResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('failed to load players');
      }
    } catch (e) {
      throw Exception('failed to load players');
    }
  }
}
