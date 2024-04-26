import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workarea_v4/adapters/app_router.dart';
import 'package:workarea_v4/blocs/auth/auth_bloc.dart';
import 'package:workarea_v4/blocs/auth/auth_event.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("This page is hidden behind authentication."),
            Text("You can only see this page if you are authenticated."),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationLogoutButtonPressed());
              },
              child: const Text("Logout"),
            ),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).pushReplacement("/");
              },
              child: const Text("Go Back To Menu Screen"),
            ),
          ],
        ),
      ),
    );
  }
}
