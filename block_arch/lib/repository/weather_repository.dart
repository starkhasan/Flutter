import 'package:block_arch/models/weather_response.dart';
import 'package:block_arch/network/api_provider.dart';

class WeatherRepository {
  var apiProvider = ApiProvider();

  Future<WeatherResponse> fetchWeather() => apiProvider.weatherDetails();
  
}
