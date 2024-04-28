import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workarea_v5/adapters/app_router.dart';
import 'package:workarea_v5/blocs/auth/auth_bloc.dart';
import 'package:workarea_v5/blocs/auth/auth_event.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationLogoutButtonPressed());
              },
              child: const Text("Logout"),
            ),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push("/data");
              },
              child: const Text("Data Screen"),
            ),
          ],
        ),
      ),
    );
  }
}
