import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workarea_v5/adapters/app_router.dart';
import 'package:workarea_v5/blocs/auth/auth_bloc.dart';
import 'package:workarea_v5/blocs/auth/auth_event.dart';
import 'dart:math' as math;

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
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) => Container(
                  color: Colors.red,
                  height: _animation.value,
                  width: _animation.value * 2),
            ),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationLogoutButtonPressed());
              },
              child: const Text("Logout"),
            ),
            ElevatedButton(
              onPressed: () {
                _controller.stop();
              },
              child: const Text("Animasyonu Durdur"),
            ),
            ElevatedButton(
              onPressed: () {
                _controller.duration = Duration(
                    seconds: math.min(_controller.duration!.inSeconds + 1, 10));
                setState(() {});
              },
              child: Text(
                  "Animasyonu Yavaşlat ${_controller.duration!.inSeconds}"),
            ),
            ElevatedButton(
              onPressed: () {
                _controller.duration = Duration(
                    seconds: math.max(
                        _controller.duration!.inMilliseconds - 1000, 100));

                setState(() {});
              },
              child: Text(
                  "Animasyonu Hızlandır ${_controller.duration!.inSeconds}"),
            ),
            ElevatedButton(
              onPressed: () {
                _controller.forward();
              },
              child: const Text("Animasyonu Başlat"),
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
