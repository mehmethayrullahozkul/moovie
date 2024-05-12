import 'package:flutter/material.dart';
import 'package:workarea_v4/adapters/app_router.dart';
import 'package:workarea_v4/adapters/auth_stream_scope_notifier.dart';
import 'package:workarea_v4/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final AuthenticationBloc authenticationBloc = AuthenticationBloc();
  runApp(BlocProvider(
    create: (context) => authenticationBloc,
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // state management => bloc
    // flutter native state management
    return AuthenticationStreamNotifyScopeProvider(
      authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
      child: MaterialApp.router(
        routerConfig: AppRouter().router,
      ),
    );
  }
}
