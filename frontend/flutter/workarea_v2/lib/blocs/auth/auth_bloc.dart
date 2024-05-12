import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'auth.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  /*  late final ValueNotifier<bool> _authNotifier;
  late final VoidCallback _authListener; */
  /*  final UserRepository userRepository; */
  AuthenticationBloc() : super(AuthenticationUninitialized()) {
    /* _authNotifier = AuthenticationService().auth;
    _authListener = () {
      print("authservice listener changed");
      if (_authNotifier.value) {
        add(AuthenticationLoggedIn());
      } else {
        add(AuthenticationLoggedOut());
      }
    };
    _authNotifier.addListener(_authListener); */

    on<AuthenticationStart>((event, emit) async {
      /* App Started */

      emit(AuthenticationLoading());
      /* await UserService().load();
      await AuthenticationService().load(); */
      /* /* FlutterNativeSplash.remove(); */ */
      /* final bool hasUser = await userRepository.hasLocalUser();
      if (hasUser) {
        final User? user = await userRepository.loadLocalUser();
        emit(AuthenticationLoading());
        userBloc.add(
            UserSetAuthenticated(mail: user!.mail, username: user.username));
      } else {
        emit(AuthenticationUnauthenticated());
      }
      if (userBloc.state is UserInvalid) {
        emit(AuthenticationUnauthenticated());
        /* FlutterNativeSplash.remove(); */
        return;
      } else if (userBloc.state is UserLoaded) {
        final User user = (userBloc.state as UserLoaded).user;
        if (user is AnonymousUser) {
          emit(AuthenticationAnonymous());
          /* FlutterNativeSplash.remove(); */
          return;
        } else if (user is AuthenticatedUser) {
          final bool hasAccessToken =
              await userRepository.hasLocalAccessToken();
          if (hasAccessToken) {
            final String? token = await userRepository.getLocalAccessToken();
            if (token != null) {
              final bool isTokenValid = await userRepository
                  .validateAccessToken(token: token, username: user.username);
              if (!isTokenValid) {
                emit(AuthenticationUnauthenticated());
              } else {
                emit(AuthenticationAuthenticated());
              }
            } else {
              emit(AuthenticationUnauthenticated());
            }
          } else {
            emit(AuthenticationUnauthenticated());
          }
          /* FlutterNativeSplash.remove(); */
          return;
        }
      } */
    });
    on<AuthenticationLoggedIn>((event, emit) {
      emit(AuthenticationLoading());
      emit(AuthenticationAuthenticated());
      /* FlutterNativeSplash.remove(); */
    });
    on<AuthenticationLoggedOut>((event, emit) {
      emit(AuthenticationLoading());
      emit(AuthenticationUnauthenticated());
      /* FlutterNativeSplash.remove(); */
    });
    on<AuthenticationLogoutButtonPressed>((event, emit) async {
      /* print("auth logout button pressed");
      await UserService().signOut();
      await AuthenticationService().signOut(); */
    });
  }

  @override
  Future<void> close() {
    /* _authNotifier.removeListener(_authListener); */
    /*  AuthenticationService().auth.dispose(); */

    return super.close();
  }
}

class AuthStreamScope extends InheritedNotifier<AuthStream> {
  static GlobalKey authStreamKey = GlobalKey();
  final AuthenticationBloc authBloc;

  AuthStreamScope({
    super.key,
    required super.child,
    required this.authBloc,
  }) : super(
          notifier: AuthStream(
              key: authStreamKey, stream: authBloc.stream, authBloc: authBloc),
        );

  static AuthStream of(BuildContext ctx) =>
      ctx.dependOnInheritedWidgetOfExactType<AuthStreamScope>()!.notifier!;

  @override
  bool updateShouldNotify(InheritedNotifier<AuthStream> oldWidget) {
    return oldWidget.notifier!.isSignedIn() != notifier!.isSignedIn();
  }
}

class AuthStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;
  late final AuthenticationBloc authBloc;
  late AuthenticationState _oldState;

  static AuthStream? _instance;

  AuthStream._({
    required Key? key,
    required Stream<dynamic> stream,
    required this.authBloc,
  }) : _oldState = authBloc.state {
    _subscription = stream.asBroadcastStream().listen((_notifyAuthListener));
  }

  factory AuthStream({
    required Key? key,
    required Stream<dynamic> stream,
    required AuthenticationBloc authBloc,
  }) {
    _instance ??= AuthStream._(key: key, stream: stream, authBloc: authBloc);
    return _instance!;
  }

  void _notifyAuthListener(dynamic event) {
    print("new event in auth stream: $event");
    print("New State: ${authBloc.state}");
    print("Old State: $_oldState");
    if (!(authBloc.state == _oldState)) {
      if (authBloc.state is AuthenticationAuthenticated ||
          authBloc.state is AuthenticationUnauthenticated) {
        _oldState = authBloc.state;
        notifyListeners();
      }
    }
  }

  bool isSignedIn() {
    if (authBloc.state is AuthenticationAuthenticated) {
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
