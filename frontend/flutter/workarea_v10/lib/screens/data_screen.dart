import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workarea_v10/adapters/app_router.dart';
import 'package:workarea_v10/blocs/auth/auth_bloc.dart';
import 'package:workarea_v10/blocs/auth/auth_event.dart';
import 'dart:math' as math;

import 'package:workarea_v10/blocs/secret_data/secret_data_bloc.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animation = Tween<double>(begin: 0.0, end: 100.0).animate(_controller)
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          _controller.reverse();
        } else if (state == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            BlocBuilder<SecretDataBloc, SecretDataState>(
                builder: (context, state) {
              if (state is SecretDataUninitialized) {
                return const Text("Secret Data Uninitialized");
              } else if (state is SecretDataLoaded) {
                return Text("Secret Data: ${state.secretData}");
              } else {
                return const Text("Secret Data Error");
              }
            }),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<SecretDataBloc>(context)
                      .add(SecretDataRequested());
                  setState(() {});
                },
                child: Text("Get Secret Data")),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(AuthenticationLogoutButtonPressed());
                  BlocProvider.of<SecretDataBloc>(context)
                      .add(SecretDataInitial());

                  setState(() {});
                },
                child: Text("Logout"))
          ],
        ),
      ),
    );
  }
}

// Inherited Notifier

// Araba::fiyatıGetir();

// Araba.fiyatıGetir();

/* class NameScopeProvider extends InheritedNotifier<NameNotifier> {
  // TODO:

  NameScopeProvider({
    required super.child,
  }) : super(notifier: NameNotifier(name: "Initial Value of Name"));

  static NameNotifier of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<NameScopeProvider>()!
        .notifier!;
  }
} */

// Parent widgetlardaki en yakın BLABLA classını bulur ve getirir.
// dependOnInheritedWidgetOfExactType<BLABLA CLASSI>

// NameScopeProvider.of

// GoRouter.of(context)
// NameScopeProvider.parentiBul(context)

// Change notifier classı bir listenable bir class tır ve bu dinlenebilir.
/* class NameNotifier extends ChangeNotifier {
  String name;

  NameNotifier({required this.name});

  void changeName(String name) {
    name = name;
    //
    notifyListeners();
  }
} */
