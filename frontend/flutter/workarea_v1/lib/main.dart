import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workarea_v1/end_goal_screen.dart';
import 'package:workarea_v1/error_page.dart';
import 'package:workarea_v1/menu.dart';
import 'package:workarea_v1/workareas/wa1.dart';
import 'package:workarea_v1/workareas/wa1_goal.dart';
import 'package:workarea_v1/workareas/wa2.dart';
import 'package:workarea_v1/workareas/wa2_goal.dart';
import 'package:workarea_v1/workareas/wa3.dart';
import 'package:workarea_v1/workareas/wa3_goal.dart';
import 'package:workarea_v1/workareas/wa4.dart';
import 'package:workarea_v1/workareas/wa4_goal.dart';
import 'package:workarea_v1/workareas/wa5.dart';
import 'package:workarea_v1/workareas/wa5_goal.dart';
import 'package:workarea_v1/workareas/wa6.dart';
import 'package:workarea_v1/workareas/wa6_goal.dart';
import 'package:workarea_v1/workareas/wa7.dart';
import 'package:workarea_v1/workareas/wa7_goal.dart';
import 'package:workarea_v1/workareas/wa8.dart';
import 'package:workarea_v1/workareas/wa8_goal.dart';
import 'package:workarea_v1/workareas/wa9.dart';
import 'package:workarea_v1/workareas/wa9_goal.dart';
import 'package:workarea_v1/workareas/wa10.dart';
import 'package:workarea_v1/workareas/wa10_goal.dart';

void main() async {
  runApp(GTUMoovieApp());
}

class GTUMoovieApp extends StatelessWidget {
  GTUMoovieApp({super.key});

  final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    errorBuilder: (context, state) =>
        ErrorPage(message: state.error.toString()),
    initialLocation: "/",
    routes: [
      GoRoute(
          path: "/",
          builder: (context, state) => const MenuScreen(),
          routes: [
            ...List.generate(workAreas.length, (index) {
              return GoRoute(
                path: "work-area-${index + 1}",
                builder: (context, state) => workAreas[index][0],
                routes: [
                  GoRoute(
                    path: "goal",
                    builder: (context, state) => workAreas[index][1],
                  ),
                ],
              );
            })
          ]),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        fontFamily: 'Nunito-Sans',
        fontSize: 24,
        fontWeight: FontWeight.w900,
        color: Colors.white,
      ),
      child: MaterialApp.router(
          theme: ThemeData(
            fontFamily: 'Nunito-Sans',
            primaryColor: Colors.green,
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: router),
    );
  }
}

const List<List<Widget>> workAreas = [
  [
    WA1(),
    WA1Goal(),
  ],
  [
    WA2(),
    WA2Goal(),
  ],
  [
    WA3(),
    WA3Goal(),
  ],
  [
    WA4(),
    WA4Goal(),
  ],
  [
    WA5(),
    WA5Goal(),
  ],
  [
    WA6(),
    WA6Goal(),
  ],
  [
    WA7(),
    WA7Goal(),
  ],
  [
    WA8(),
    WA8Goal(),
  ],
  [
    WA9(),
    WA9Goal(),
  ],
  [
    WA10(),
    WA10Goal(),
  ],
];
