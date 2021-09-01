import 'dart:async';
import 'package:block_arch/bloc/bloc_states/weather_state.dart';
import 'package:block_arch/models/weather_response.dart';
import 'package:block_arch/repository/weather_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum WeatherEvent { initialRequestEvent, fabRequestEvent, refereshRequestEvent }

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherUninitializedState());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    yield WeatherFetchingState();
    late WeatherResponse weatherResponse;
    try {
      if (event == WeatherEvent.initialRequestEvent || event == WeatherEvent.fabRequestEvent) {
        weatherResponse = await WeatherRepository().fetchWeather();
      }
      yield WeatherFetchedState(weatherResponse: weatherResponse);
    } catch (e) {
      yield WeatherErrorState();
    }
  }
}
