import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workarea_v9/Blocs/authentication_bloc.dart';
import 'package:workarea_v9/Blocs/authentication_event.dart';
import 'package:workarea_v9/Blocs/authentication_state.dart';
import 'package:workarea_v9/Screens/Datascreen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late final TextEditingController _textFieldController1;
  late final TextEditingController _textFieldController2;
  @override
  void initState() {
    _textFieldController1 = TextEditingController();
    _textFieldController2 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _textFieldController1.dispose();
    _textFieldController2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu Screen",
          style: TextStyle(
            backgroundColor: const Color.fromARGB(255, 220, 155, 57),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _textFieldController1,
            decoration: InputDecoration(
              hintText: 'Enter text 1',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 15),
          TextField(
            controller: _textFieldController2,
            decoration: InputDecoration(
              hintText: 'Enter text 2',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              String text1 = _textFieldController1.text;
              String text2 = _textFieldController2.text;
              print('Text 1: $text1, Text 2: $text2');
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(ButtonPressedEvent(text1, text2));
            },
            child: Text("Login"),
          ),
          SizedBox(height: 15),
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationUnauthenticated) {
                return Text("Login failed");
              } else if (state is AuthenticationAuthenticated) {
                return Text("Login successful");
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
