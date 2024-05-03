import 'package:flutter/material.dart';
import 'package:workarea_v5/adapters/app_router.dart';
import 'package:workarea_v5/adapters/auth_stream_scope_notifier.dart';
import 'package:workarea_v5/blocs/auth/auth_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workarea_v5/blocs/auth/auth_event.dart';
import 'package:workarea_v5/blocs/auth/auth_state.dart';
import 'package:workarea_v5/models/user/user_credentials_realm.dart';
import 'package:workarea_v5/models/user/user_model.dart';
import 'package:workarea_v5/models/user/user_realm.dart';
import 'package:workarea_v5/repository/user_repository.dart';

void main() async {
  final UserRepository userRepository = await UserRepository.init();

  print("Adding new user to the database ");
  userRepository.saveUser(UserModel.createRealm(
      username: "hayrullah",
      emailAddress: "hayrullahozkul@gmail.com",
      isValid: true));

  userRepository.saveUserCredentials(
      UserCredentialsRealm("hayrullah", "123456", "asdasdasda"));

  Iterable<UserRealm> users = await userRepository.getAllUsers();
  Iterable<UserCredentialsRealm> userCredentials =
      await userRepository.getAllUserCredentials();

  for (UserRealm user in users) {
    print("New User Found: ${user.username}");
  }

  for (UserCredentialsRealm userCredential in userCredentials) {
    print(
        "New User Credential Found: ${userCredential.username}, ${userCredential.accessToken}, ${userCredential.refreshToken}");
  }

  final AuthenticationBloc authenticationBloc =
      AuthenticationBloc(userRepository: userRepository)
        ..add(AuthenticationStart());
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
