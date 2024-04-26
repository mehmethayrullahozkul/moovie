import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workarea_v4/blocs/auth/auth_event.dart';
import 'package:workarea_v4/blocs/auth/auth_state.dart';
import 'package:workarea_v4/services/authentication_service.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationUninitialized()) {
    on<AuthenticationStart>((event, emit) {
      // Check the authentication

      emit(AuthenticationUninitialized());
    });
    on<AuthenticationApproved>((event, emit) {
      emit(AuthenticationAuthenticated());
    });
    on<AuthenticationDenied>((event, emit) {
      emit(AuthenticationUnauthenticated());
    });
    on<AuthenticationLoginButtonPressed>((event, emit) {
      bool auth =
          AuthenticationService().authenticate(event.username, event.password);
      if (auth) {
        emit(const AuthenticationAuthenticated());
      } else {
        emit(const AuthenticationUnauthenticated());
      }
    });
    on<AuthenticationLogoutButtonPressed>((event, emit) {
      emit(const AuthenticationUnauthenticated());
    });
  }
}
