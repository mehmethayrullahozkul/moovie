import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workarea_v6/adapters/app_router.dart';
import 'package:workarea_v6/adapters/auth_stream_scope_notifier.dart';
import 'package:workarea_v6/blocs/authentication/auth_bloc.dart';
import 'package:workarea_v6/blocs/authentication/auth_state.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    authenticationBloc = AuthenticationBloc();
    AppRouter.init(authenticationBloc: authenticationBloc);
    GoRouter.optionURLReflectsImperativeAPIs = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authenticationBloc,
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          print("listener wakened");
          AppRouter().router.refresh();
          print("after router refreshed");
        },
        child: MaterialApp.router(
          routerConfig: AppRouter().router,
        ),
      ),
    );
  }
}
