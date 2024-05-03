import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workarea_v6/blocs/authentication/auth_bloc.dart';
import 'package:workarea_v6/blocs/authentication/auth_event.dart';
import 'package:workarea_v6/blocs/authentication/auth_state.dart';

class MenuScreen extends StatefulWidget {
  @override
  State<MenuScreen> createState() => _MenuScreenState();

  const MenuScreen({super.key});
}

class _MenuScreenState extends State<MenuScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
              ),
              TextField(
                controller: _passwordController,
              ),
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context).add(
                        AuthenticationLoginButtonPressed(
                            username: _usernameController.text,
                            password: _passwordController.text));
                  },
                  child: Text("Try to Login")),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                if (state is AuthenticationAuthenticated) {
                  return Text("Current State: Authenticated");
                } else if (state is AuthenticationUnauthenticated) {
                  return Text("Current State: Unauthenticated");
                } else if (state is AuthenticationUninitialized) {
                  return Text("Current State: Not Initialized Yet");
                }
                return Text("Unknown?");
              }),
              ElevatedButton(
                  onPressed: () {
                    GoRouter.of(context).go("/data");
                  },
                  child: const Text("Go To Data Screeen")),
            ],
          ),
        ),
      ),
    );
  }
}
