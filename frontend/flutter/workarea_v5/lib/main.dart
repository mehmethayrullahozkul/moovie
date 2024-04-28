import 'package:flutter/material.dart';
import 'package:workarea_v5/adapters/app_router.dart';
import 'package:workarea_v5/adapters/auth_stream_scope_notifier.dart';
import 'package:workarea_v5/blocs/auth/auth_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workarea_v5/blocs/auth/auth_state.dart';
import 'package:workarea_v5/models/user/user_model.dart';
import 'package:workarea_v5/models/user/user_realm.dart';
import 'package:workarea_v5/repository/user_repository.dart';

void main() async {
  final UserRepository userRepository = await UserRepository.init();

  print("Adding new user to the database ");
  userRepository.addUser(UserModel.createRealm(
      username: "hayrullah",
      password: "asdasdasdas",
      emailAddress: "hayrullahozkul@gmail.com",
      isValid: true));

  Iterable<UserRealm> users = await userRepository.getAllUsers();

  for (UserRealm user in users) {
    print("New User Found: ${user.username}");
  }
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
    // BlocBuilder ?
    /*
        State değişiminde rebuild
    */

    // BlocListener
    /*
        State değişiminde gerçekleşmesi istenen logici gerçekleştirir
    */

    /*
    
    BlocBuilder : state değiştiğinde rebuild
    BlocListener: state değiştiğinde logici gerçekleştirir
     */
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        // her state değiştiğinde buradaki komutlar uygulanır
        AppRouter().router.refresh();
      },
      child: MaterialApp.router(
        routerConfig: AppRouter().router,
      ),
    );
  }
}
