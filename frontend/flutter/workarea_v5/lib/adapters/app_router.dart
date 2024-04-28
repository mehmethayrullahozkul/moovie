import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:workarea_v5/adapters/auth_stream_scope_notifier.dart';
import 'package:workarea_v5/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workarea_v5/blocs/auth/auth_state.dart';
import 'package:workarea_v5/screens/data_screen.dart';
import 'package:workarea_v5/screens/login_screen.dart';
import 'package:workarea_v5/screens/menu_screen.dart';

class AppRouter {
  static final AppRouter _instance = AppRouter._internal();
  late final GoRouter _router;

  GoRouter get router => _router;

  AppRouter._internal() {
    _router = GoRouter(
        initialLocation: "/",
        errorBuilder: (context, state) =>
            const Scaffold(body: Text("Error, Page Does Not Exist!")),
        routes: [
          GoRoute(
              path: "/login",
              name: "login",
              builder: (context, state) => const LoginScreen()),
          GoRoute(
              path: "/",
              name: "/",
              builder: (context, state) => const MenuScreen(),
              routes: [
                GoRoute(
                  path: "data",
                  name: "data",
                  builder: (context, state) => DataScreen(),
                )
              ])
        ],
        // yeni bir pushlarken veya bir sayfaya giderken bir kontrol yapmak için kullanılır
        redirect: (BuildContext context, state) {
          print("redirect request sent");
          bool isSignedIn =
              /* AuthenticationStreamNotifyScopeProvider.of(context).isSignedIn(); */

              BlocProvider.of<AuthenticationBloc>(context).state
                  is AuthenticationAuthenticated;

          bool isInLoginScreen = state.fullPath == "/login";

          if (isSignedIn && isInLoginScreen) {
            print("redirecting to /");
            return "/";
          } else if (!isSignedIn && !isInLoginScreen) {
            // kullanıcı çıkış yapmış ama menüye girmeye çalışıyo
            print("redirecting to /login");
            return "/login";
          } else {
            // hiç bir yönlendirme yapma
            print("no redirect");
            return null;
          }
        });
  }

  factory AppRouter() {
    return _instance;
  }
}

// GoRouter.of(context).push("/login");

