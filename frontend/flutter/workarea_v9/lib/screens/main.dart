import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workarea_v9/Blocs/authentication_bloc.dart';
import 'package:workarea_v9/Blocs/authentication_event.dart';
import 'package:workarea_v9/Blocs/authentication_state.dart';
import 'package:workarea_v9/Blocs/SecretDataBloc/SecretDataBloc.dart'; // Import SecretDataBloc
import 'package:workarea_v9/Screens/Datascreen.dart';
import 'package:workarea_v9/Screens/Menu.dart';
import 'package:workarea_v9/Service/AuthenticationService.dart';

void main() async {
  final AuthenticationService authenticationService = AuthenticationService();
  final authenticationBloc = AuthenticationBloc(authenticationService);
  authenticationBloc.add(AuthenticationStart());
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>.value(value: authenticationBloc),
        BlocProvider<SecretDataBloc>(
          create: (context) =>
              SecretDataBloc(authenticationService: authenticationService),
        ),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final GoRouter router;
  @override
  void initState() {
    super.initState();
    router = GoRouter(
        initialLocation: "/",
        routes: [
          GoRoute(path: "/", builder: (context, state) => const MenuScreen()),
          GoRoute(
            path: "/data_screen",
            builder: (context, state) {
              return DataScreen();
            },
          ),
        ],
        redirect: (BuildContext context, state) {
          print("redirect request sent");
          bool isSignedIn = BlocProvider.of<AuthenticationBloc>(context).state
              is AuthenticationAuthenticated;
          bool isInMenuScreen = state.fullPath == "/";
          if (isSignedIn && isInMenuScreen) {
            return "/data_screen";
          } else if (!isSignedIn) {
            return "/";
          } else {
            return null;
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        router.refresh();
      },
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}
