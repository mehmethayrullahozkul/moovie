import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workarea_v5/blocs/auth/auth_event.dart';
import 'package:workarea_v5/blocs/auth/auth_state.dart';
import 'package:workarea_v5/services/authentication_service.dart';

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
    on<AuthenticationLoginButtonPressed>((event, emit) async {
      emit(const AuthenticationLoading());

      // güya database bakiyoruz
      await Future.delayed(const Duration(seconds: 2));
      bool auth = AuthenticationService()
          .authenticate(username: event.username, password: event.password);
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
