import 'package:block_arch/models/weather_response.dart';

abstract class WeatherState {}

class WeatherUninitializedState extends WeatherState {}

class WeatherFetchingState extends WeatherState {}

class WeatherFetchedState extends WeatherState {
  final WeatherResponse weatherResponse;
  WeatherFetchedState({required this.weatherResponse});
}

class WeatherErrorState extends WeatherState {}
