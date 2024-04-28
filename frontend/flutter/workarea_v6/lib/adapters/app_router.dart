import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:workarea_v6/screens/data_screen.dart';
import 'package:workarea_v6/screens/login_screen.dart';
import 'package:workarea_v6/blocs/giris/giris_state.dart';
import 'package:workarea_v6/blocs/giris/giris_bloc.dart';
import 'package:workarea_v6/blocs/giris/giris_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static final AppRouter _instance = AppRouter._internal();
  late final GoRouter _router;

  GoRouter get router => _router;

  AppRouter._internal() {
    _router = GoRouter(
        initialLocation: "/login",
        errorBuilder: (context, state) =>
            const Scaffold(body: Text("Error, Page Does Not Exist!")),
        routes: [
          GoRoute(
              path: "/login",
              name: "login",
              builder: (context, state) => const LoginScreen()),
          GoRoute(
              path: "/data",
              name: "data",
              builder: (context, state) => const DataScreen(),
            )
        ],
        redirect: (BuildContext context, state) {
          bool isSignedIn = BlocProvider.of<GirisBloc>(context).state
              is GirisYapildi;

          bool isInLoginScreen = state.fullPath == "/login";

          if (isSignedIn && isInLoginScreen) {
            print("redirecting to /");
            return "/login";
          } else if (!isSignedIn && !isInLoginScreen) {
            // kullanıcı çıkış yapmış ama menüye girmeye çalışıyo
            print("redirecting to /login");
            return "/login";
          } else {
            // hiç bir yönlendirme yapma
            print("no redirect");
            return null;
          }
        }
     );
  }

  factory AppRouter() {
    return _instance;
  }
}
