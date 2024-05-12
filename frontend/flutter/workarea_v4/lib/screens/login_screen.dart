import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workarea_v4/blocs/auth/auth_bloc.dart';
import 'package:workarea_v4/blocs/auth/auth_event.dart';
import 'package:workarea_v4/blocs/auth/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 247, 247, 247),
        scrolledUnderElevation: 0,
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 0),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Color.fromARGB(255, 43, 43, 43), width: 0.1)),
            ),
            child: Text(
              'Moovie Login Screen',
              style: TextStyle(
                  color: Color.fromARGB(255, 43, 43, 43),
                  fontFamily: 'Sofia-Pro',
                  fontWeight: FontWeight.w900,
                  fontSize: 30),
            ),
          ),
        ),
        titleSpacing: 20,
      ),
      body: SizedBox(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.84,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 0, 0, 0),
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Enter the username",
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 61, 61, 61),
                              fontFamily: "Sofia-Pro",
                              fontWeight: FontWeight.w300,
                            ),
                            focusedBorder: InputBorder.none),
                        style: TextStyle(
                            color: const Color.fromARGB(255, 34, 34, 34)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 0, 0, 0),
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Enter the password",
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 61, 61, 61),
                              fontFamily: "Sofia-Pro",
                              fontWeight: FontWeight.w300,
                            ),
                            focusedBorder: InputBorder.none),
                        style: TextStyle(
                            color: const Color.fromARGB(255, 34, 34, 34)),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () =>
                        BlocProvider.of<AuthenticationBloc>(context).add(
                            AuthenticationLoginButtonPressed(
                                username: _usernameController.text,
                                password: _passwordController.text)),
                    child: Text('Login')),
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                  print("Current Auth State is:  $state");
                  if (state is AuthenticationUnauthenticated) {
                    return Text('Login failed');
                  } else if (state is AuthenticationLoading) {
                    return Text('Login loading');
                  } else if (state is AuthenticationUninitialized) {
                    return Text('Login inital state');
                  } else if (state is AuthenticationAuthenticated) {
                    return Text('Login successful');
                  }
                  return Container();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
