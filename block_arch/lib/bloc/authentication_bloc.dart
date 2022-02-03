import 'package:block_arch/bloc/bloc_states/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AuthEvent {}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;
  AuthEventLogin({required this.email, required this.password});
}

class AuthenticationBloc extends Bloc<AuthEvent, AuthState> {
  AuthenticationBloc() : super(AuthInitialState()) {
    on<AuthEventLogin>((event, emit) {
      if (event.email.isNotEmpty && event.password.isNotEmpty) {
        emit(AuthSucess());
      } else {
        emit(AuthFailed());
      }
    });
  }
}
