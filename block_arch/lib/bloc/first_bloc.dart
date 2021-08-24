import 'package:flutter_bloc/flutter_bloc.dart';

enum CounterEvent { increment, decrement }

class FirstBloc extends Bloc<CounterEvent, int> {
  FirstBloc() : super(0);
  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        yield state + 1;
        break;
      case CounterEvent.decrement:
        if(state != 0) yield state - 1;
        break;
    }
  }
}
