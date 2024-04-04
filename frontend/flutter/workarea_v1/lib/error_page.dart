import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  final message;

  const ErrorPage({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color:
              const Color.fromARGB(255, 241, 241, 241), //change your color here
        ),
        backgroundColor: const Color.fromARGB(255, 20, 20, 20),
        scrolledUnderElevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 0.0),
          child: Text('Routing Error',
              style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 22,
                  fontWeight: FontWeight.w500)),
        ),
      ),
      body: Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Text(
              'Error: $message',
              style: TextStyle(fontSize: 24),
            )),
      ),
    );
  }
}
