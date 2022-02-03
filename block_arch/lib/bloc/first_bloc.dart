import 'package:flutter_bloc/flutter_bloc.dart';

enum CounterEvent { increment, decrement }

class FirstBloc extends Bloc<CounterEvent, int> {
  FirstBloc() : super(0) {
    on<CounterEvent>((event, emit){
      switch (event) {
        case CounterEvent.increment:
          emit(state + 1);
          break;
        case CounterEvent.decrement:
          if(state != 0) emit(state - 1);
          break;
      }
    });
  }
}