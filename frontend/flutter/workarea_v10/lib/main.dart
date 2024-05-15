import 'package:flutter/material.dart';
import 'package:workarea_v10/adapters/app_router.dart';
import 'package:workarea_v10/blocs/auth/auth_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workarea_v10/blocs/auth/auth_event.dart';
import 'package:workarea_v10/blocs/auth/auth_state.dart';
import 'package:workarea_v10/blocs/secret_data/secret_data_bloc.dart';
import 'package:workarea_v10/models/user/user_model.dart';
import 'package:workarea_v10/repository/user_repository.dart';
import 'package:workarea_v10/services/authentication_service.dart';

void main() async {
  final UserRepository userRepository = await UserRepository.init();

  final AuthenticationService authenticationService = AuthenticationService();

  authenticationService.initialize(userRepository: userRepository);

  final AuthenticationBloc authenticationBloc =
      AuthenticationBloc(authenticationService: authenticationService)
        ..add(AuthenticationStart());

  final SecretDataBloc secretDataBloc =
      SecretDataBloc(authenticationService: authenticationService);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>(
        create: (context) => authenticationBloc,
      ),
      BlocProvider<SecretDataBloc>(
        create: (context) => secretDataBloc,
      ),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        AppRouter().router.refresh();
      },
      child: MaterialApp.router(
        routerConfig: AppRouter().router,
      ),
    );
  }
}
