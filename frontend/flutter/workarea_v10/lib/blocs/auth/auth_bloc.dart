import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workarea_v10/blocs/auth/auth_event.dart';
import 'package:workarea_v10/blocs/auth/auth_state.dart';
import 'package:workarea_v10/repository/user_repository.dart';
import 'package:workarea_v10/services/authentication_service.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  late final ValueNotifier<bool> _authNotifier;
  final AuthenticationService authenticationService;
  late final VoidCallback _authListener;

  AuthenticationBloc({required this.authenticationService})
      : super(const AuthenticationUninitialized()) {
    _authNotifier = AuthenticationService().auth;
    _authListener = () {
      if (_authNotifier.value == true) {
        add(AuthenticationApproved());
      } else {
        add(AuthenticationDenied());
      }
    };

    _authNotifier.addListener(_authListener);

    on<AuthenticationStart>((event, emit) {
      emit(const AuthenticationLoading());
      // Check the authentication
      AuthenticationService().start();
    });
    on<AuthenticationApproved>((event, emit) {
      emit(AuthenticationAuthenticated());
    });
    on<AuthenticationDenied>((event, emit) {
      emit(AuthenticationUnauthenticated());
    });
    on<AuthenticationLoginButtonPressed>((event, emit) async {
      emit(const AuthenticationLoading());

      AuthenticationService()
          .signIn(username: event.username, password: event.password);
    });
    on<AuthenticationLogoutButtonPressed>((event, emit) {
      emit(const AuthenticationUnauthenticated());
      AuthenticationService().signOut();
    });
  }
}
