import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workarea_v6/blocs/giris/giris_state.dart';
import 'package:workarea_v6/blocs/giris/giris_bloc.dart';
import 'package:workarea_v6/blocs/giris/giris_event.dart';

import 'package:workarea_v6/adapters/app_router.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final GoRouter router;

  @override
  void initState() {
    router = AppRouter().router;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => GirisBloc(),
      child:
        BlocListener<GirisBloc , GirisState>(
          listener:(context, state) => {
              AppRouter().router.refresh(),
              
          },
          child: MaterialApp.router(
        routerConfig: AppRouter().router,
      ),
        ),
      
    );
  }
}
