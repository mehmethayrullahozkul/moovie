import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workarea_v6/adapters/authentication_service.dart';
import 'package:workarea_v6/blocs/authentication/auth_event.dart';
import 'package:workarea_v6/blocs/authentication/auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationUninitialized()) {
    on<AuthenticationStarted>((event, emit) {
      emit(AuthenticationUninitialized());
    });
    on<AuthenticationLoginButtonPressed>((event, emit) {
      bool tryLogin = AuthenticationService.authenticate(
          username: event.username, password: event.password);

      if (tryLogin) {
        emit(AuthenticationAuthenticated());
      } else {
        emit(AuthenticationUnauthenticated());
      }
    });
    on<AuthenticationLogoutButtonPressed>((event, emit) {
      emit(AuthenticationLoading());
      emit(AuthenticationUnauthenticated());
    });
  }
}
