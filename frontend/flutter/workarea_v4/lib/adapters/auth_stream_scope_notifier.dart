import 'dart:async';

import 'package:flutter/material.dart';
import 'package:workarea_v4/blocs/auth/auth_bloc.dart';
import 'package:workarea_v4/blocs/auth/auth_state.dart';

class AuthenticationStreamNotifyScopeProvider
    extends InheritedNotifier<AuthenticationStreamNotifier> {
  final AuthenticationBloc authenticationBloc;

  AuthenticationStreamNotifyScopeProvider({
    super.key,
    required this.authenticationBloc,
    required super.child,
  }) : super(
            notifier: AuthenticationStreamNotifier(
                authenticationBloc: authenticationBloc));

  static AuthenticationStreamNotifier of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<
          AuthenticationStreamNotifyScopeProvider>()!
      .notifier!;
}

class AuthenticationStreamNotifier extends ChangeNotifier {
  late final StreamSubscription<dynamic> _authSubscription;
  late AuthenticationState _oldState;
  final AuthenticationBloc authenticationBloc;

  static AuthenticationStreamNotifier? _instance;

  AuthenticationStreamNotifier._({
    required this.authenticationBloc,
  }) : _oldState = authenticationBloc.state {
    _authSubscription = authenticationBloc.stream
        .asBroadcastStream()
        .listen(_notifyAuthListener);
  }

  factory AuthenticationStreamNotifier(
      {required AuthenticationBloc authenticationBloc}) {
    _instance ??=
        AuthenticationStreamNotifier._(authenticationBloc: authenticationBloc);
    return _instance!;
  }

  void _notifyAuthListener(dynamic event) {
    if (authenticationBloc.state != _oldState) {
      _oldState = authenticationBloc.state;
      notifyListeners();
    }
  }

  bool isSignedIn() {
    return authenticationBloc.state is AuthenticationAuthenticated;
  }
}
