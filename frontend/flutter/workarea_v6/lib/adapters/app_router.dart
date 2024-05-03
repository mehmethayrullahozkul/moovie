import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workarea_v6/adapters/auth_stream_scope_notifier.dart';
import 'package:workarea_v6/blocs/authentication/auth_bloc.dart';
import 'package:workarea_v6/blocs/authentication/auth_state.dart';
import 'package:workarea_v6/screens/data_screen.dart';
import 'package:workarea_v6/screens/menu_screen.dart';

class AppRouter {
  static late final AppRouter _instance;
  static late final AuthenticationBloc authenticationBloc2;
  static late final GoRouter _router;

  GoRouter get router => _router;

  void dispose() {
    _router!.dispose();
  }

  static void init({required AuthenticationBloc authenticationBloc}) {
    authenticationBloc2 = authenticationBloc;
    _instance = AppRouter._();
  }

  factory AppRouter() {
    return _instance;
  }

  AppRouter._() {
    _router = GoRouter(
        debugLogDiagnostics: true,
        initialLocation: "/",
        routes: [
          GoRoute(
              path: "/login",
              name: "login",
              builder: (context, state) => const MenuScreen()),
          GoRoute(
              path: "/data",
              name: "data",
              builder: (context, state) => const DataScreen()),
        ],
        /* errorBuilder: (context, state) => Scaffold(
              body: Center(
                child: Text("Error Page ${error}"),
              ),
            ), */
        /* refreshListenable: GoRouterRefreshStream(authenticationBloc2.stream), */
        redirect: (BuildContext context, state) {
          print("redirect func called");
          print("current fullpath: ${state.uri.toString()}");
          print(BlocProvider.of<AuthenticationBloc>(context).state);
          bool isLoggedIn = BlocProvider.of<AuthenticationBloc>(context).state
              is AuthenticationAuthenticated;

          /*
          this is what makes this redirect function listen to notifiers
          */
          /* bool isLoggedIn =
              AuthenticationStreamNotifyScopeProvider.of(context).isSignedIn(); */

          if (!isLoggedIn) {
            print("unauthorized, going to menu");

            return "/login";
          } else {
            print("authorized");

            print(state.fullPath);
            return null;
          }
        });
  }
}

/* class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
 */