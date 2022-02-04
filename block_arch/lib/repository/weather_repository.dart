import 'dart:io';

import 'package:block_arch/bloc/bloc_states/weather_state.dart';
import 'package:block_arch/models/weather_response.dart';
import 'package:block_arch/network/api_provider.dart';
import 'dart:convert';

class WeatherRepository {
  var apiProvider = ApiProvider();
  
  Future<WeatherState> fetchWeatherData() async {
    var response = await apiProvider.getWeatherDetails();
    if(response is SocketException){
      return WeatherNoInternetState();
    }else if (response.statusCode == 200) {
      WeatherResponse data = WeatherResponse.fromJson(jsonDecode(response.body));
      return WeatherFetchedState(weatherResponse: data);
    }
    return WeatherErrorState();
  }
}
