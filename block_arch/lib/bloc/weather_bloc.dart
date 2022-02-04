import 'package:block_arch/bloc/bloc_states/weather_state.dart';
import 'package:block_arch/repository/weather_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class WeatherEvent {}
class WeatherInitialRequest extends WeatherEvent {}
class WeatherFabRequest extends WeatherEvent {}
class WeatherRefreshRequest extends WeatherEvent {}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherUninitializedState()){
    on<WeatherEvent>((event, emit) async{
      emit(WeatherFetchingState());
      var weatherState = await WeatherRepository().fetchWeatherData();
      emit(weatherState);
    });
  }
}
