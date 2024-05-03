import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workarea_v6/blocs/authentication/auth_bloc.dart';
import 'package:workarea_v6/blocs/authentication/auth_event.dart';
import 'package:workarea_v6/blocs/authentication/auth_state.dart';

class DataScreen extends StatefulWidget {
  @override
  State<DataScreen> createState() => _DataScreenState();

  const DataScreen({super.key});
}

class _DataScreenState extends State<DataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    print("before adding logout event");
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(AuthenticationLogoutButtonPressed());
                    print("after adding logout event");
                    print(
                        "current path: ${GoRouterState.of(context).uri.toString()}");
                  },
                  child: Text("Log Out")),
              ElevatedButton(
                  onPressed: () {
                    GoRouter.of(context).pushReplacement("/login");
                  },
                  child: const Text("Go Back To Menu without Logout")),
            ],
          ),
        ),
      ),
    );
  }
}
