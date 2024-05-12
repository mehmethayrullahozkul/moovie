import 'package:flutter/material.dart';
import 'package:workarea_v8/blocs/word_pair/word_pair_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workarea_v8/blocs/word_pair/word_pair_event.dart';
import 'package:workarea_v8/blocs/word_pair/word_pair_state.dart';

import 'package:workarea_v8/screens/menu_screen.dart';
import 'package:workarea_v8/services/data_service.dart';

void main() async {
  final DataService dataService = await DataService.init();

  final WordPairDataBloc wordPairDataBloc =
      WordPairDataBloc(dataService: dataService);

  runApp(BlocProvider(
    create: (context) => wordPairDataBloc,
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MenuScreen(),
    );
  }
}
