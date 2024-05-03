import 'package:flutter/material.dart';
import 'package:workarea_v7/blocs/game_state/game_state_bloc.dart';
import 'package:workarea_v7/screens/game_screen.dart';
import 'package:workarea_v7/services/game_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final GameService gameService = GameService();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameStateBloc(gameService: gameService),
      child: const MaterialApp(
        home: GameScreen(),
      ),
    );
  }
}
