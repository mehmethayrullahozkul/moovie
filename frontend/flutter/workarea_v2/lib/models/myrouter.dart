import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:workarea_v2/models/page1.dart';
import 'package:workarea_v2/models/page2.dart';
import 'package:workarea_v2/screens/menu.dart';
import '../../../blocs/auth/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class AppRouter {
  static GoRouter? router;
  static int index = 0;
  static final AppRouter _singleton = AppRouter._internal();

  AppRouter._internal();

  factory AppRouter() {
    return _singleton;
  }

  static GoRouter initRouter(BuildContext context) {
    router = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: "/menu",
      errorBuilder: (BuildContext context, GoRouterState state) =>
          const Center(child: Text("Error")),
      routes: [
        GoRoute(
            name: "menu",
            path: "/menu",
            builder: (BuildContext context, GoRouterState state) =>
                MenuScreen()),
        GoRoute(
            name: "page1",
            path: "/page1",
            builder: (context, state) => Page1Screen()),
        GoRoute(
            name: "page2",
            path: "/page2",
            builder: (context, state) => Page2Screen()),
      ],
      /* refreshListenable: BlocProvider.of<AuthenticationBloc>(context).stream, */
      /*  redirect: (BuildContext context, GoRouterState states) {
          /* final bool loggedIn = AuthStreamScope.of(context).isSignedIn(); */
          final bool loggedIn = BlocProvider.of<AuthenticationBloc>(context)
              .state is AuthenticationAuthenticated;

          final bool isLoginScreen = states.fullPath == "/login" ? true : false;
          if (!loggedIn && !isLoginScreen) {
            // User not logged in and not on login screen
            index = -1;
            return "/login";
          }
          if (loggedIn && isLoginScreen) {
            // User logged in and on login screen
            index = 0;
            return "/menu";
          }

          // User logged in and not on login screen
          // do nothing

          return null;
        } */
    );
    return router!;
  }
}
