import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workarea_v7/blocs/game_state/game_state_bloc.dart';
import 'package:workarea_v7/models/constants.dart';
import 'package:workarea_v7/screens/action_bar.dart';

class GameScreen extends StatefulWidget {
  @override
  State<GameScreen> createState() => _GameScreenState();

  const GameScreen({super.key});
}

class _GameScreenState extends State<GameScreen> {
  final Map<GameResult, String> mappingResult = {
    GameResult.draw: "Draw!",
    GameResult.win: "Win!",
    GameResult.lose: "Lose!",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GameStateBloc, GameStateState>(
        builder: (context, state) {
          if (state is GameStateWaiting) {
            return Container(
              margin: const EdgeInsets.all(48),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Rock Paper Scissors',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Choose your weapon',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ActionBar(
                    onChoose: (actionType) {
                      BlocProvider.of<GameStateBloc>(context).add(PlayGame(
                          player1PlayType: PlayType.paper,
                          player2PlayType: PlayType.paper));
                    },
                    disabled: false,
                  ),
                ],
              ),
            );
          }

          if (state is GameStateEnd) {
            return Container(
              margin: const EdgeInsets.all(48),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Rock Paper Scissors',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30),
                        Builder(builder: (context) {
                          final gameResult =
                              BlocProvider.of<GameStateBloc>(context)
                                  .gameResult
                                  .value;
                          final winner = context.select(
                              (GameStateBloc bloc) => bloc.winner.value);
                          return (gameResult == GameResult.draw)
                              ? Text(
                                  'Draw!',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : (gameResult == GameResult.win)
                                  ? Text(
                                      'Win!',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Text(
                                      'Lose!',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                          /* Text(
                            mappingResult[winner.gameResult] ?? '',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ); */
                        }),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<GameStateBloc>(context).add(ResetRound());
                    },
                    child: Text(
                      'Play Again',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0.0),
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xfff9d835),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is GameStatePlaying) {
            return Container(
              margin: const EdgeInsets.all(48),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Rock Paper Scissors',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Choose your weapon',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ActionBar(
                    onChoose: (actionType) {
                      context.read<GameStateBloc>().add(PlayGame(
                          player1PlayType: actionType,
                          player2PlayType: PlayType.paper));
                    },
                    disabled: true,
                  ),
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
