import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workarea_v5/blocs/auth/auth_event.dart';
import 'package:workarea_v5/blocs/auth/auth_state.dart';
import 'package:workarea_v5/repository/user_repository.dart';
import 'package:workarea_v5/services/authentication_service.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  late final ValueNotifier<bool> _authNotifier;
  final UserRepository userRepository;
  late final VoidCallback _authListener;

  AuthenticationBloc({required this.userRepository})
      : super(const AuthenticationUninitialized()) {
    _authNotifier = AuthenticationService().auth;
    _authListener = () {
      if (_authNotifier.value == true) {
        add(AuthenticationApproved());
      } else {
        add(AuthenticationDenied());
      }
    };
    //notifyListener();
    //veya değeri değişirse
    _authNotifier.addListener(_authListener);

    on<AuthenticationStart>((event, emit) {
      emit(const AuthenticationLoading());
      // Check the authentication
      AuthenticationService().load(userRepository: userRepository);
    });
    on<AuthenticationApproved>((event, emit) {
      emit(AuthenticationAuthenticated());
    });
    on<AuthenticationDenied>((event, emit) {
      emit(AuthenticationUnauthenticated());
    });
    on<AuthenticationLoginButtonPressed>((event, emit) async {
      emit(const AuthenticationLoading());

      /*
        bool auth = AuthenticationService().authenticate;

        if(auth)
          emit(AuthenticateAuthenticated())
        else
        {
          emit(AuthenticateUnauthenticated())
        }
       */
      AuthenticationService()
          .signIn(username: event.username, password: event.password);
    });
    on<AuthenticationLogoutButtonPressed>((event, emit) {
      emit(const AuthenticationUnauthenticated());
    });
  }
}
