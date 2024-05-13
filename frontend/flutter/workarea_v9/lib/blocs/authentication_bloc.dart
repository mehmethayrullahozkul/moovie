import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workarea_v9/Blocs/authentication_event.dart';
import 'package:workarea_v9/Blocs/authentication_state.dart';
import 'package:workarea_v9/Repository/Repository.dart';
import 'package:workarea_v9/Service/AuthenticationService.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository = UserRepository();
  final AuthenticationService authenticationService;
  late final ValueNotifier<bool> _authNotifier;
  late final VoidCallback _authListener;

  AuthenticationBloc(this.authenticationService) : super(initialState()) {
    _authNotifier = AuthenticationService().auth;
    _authListener = () {
      if (_authNotifier.value == true) {
        add(AuthenticationApproved());
      } else {
        add(AuthenticationDenied());
      }
    };

    _authNotifier.addListener(_authListener);
    on<ButtonPressedEvent>((event, emit) async {
      authenticationService.signIn(event.username!, event.password!);
    });
    on<UnbuttonPressedevent>((event, emit) async {
      await authenticationService.signOut();
      emit(AuthenticationUnauthenticated());
    });
    on<AuthenticationApproved>((event, emit) async {
      emit(AuthenticationAuthenticated());
    });
    on<AuthenticationDenied>((event, emit) async {
      emit(AuthenticationUnauthenticated());
    });
    on<AuthenticationStart>((event, emit) async {
      authenticationService.initialize(userRepository: userRepository);
    });
  }
}
