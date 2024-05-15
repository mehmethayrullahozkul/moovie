import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workarea_v7/blocs/game_state/game_state_bloc.dart';
import 'package:workarea_v7/models/constants.dart';
import 'package:workarea_v7/screens/action_bar.dart';

class GameScreen extends StatefulWidget {
  @override
  State<GameScreen> createState() => _GameScreenState();

  const GameScreen({super.key});
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  final Map<PlayType, IconData> mappingIcon = {
    PlayType.paper: FontAwesomeIcons.solidHand,
    PlayType.rock: FontAwesomeIcons.solidHandBackFist,
    PlayType.scissors: FontAwesomeIcons.solidHandScissors,
  };

  late final AnimationController _playerAnimationController;
  late final AnimationController _opponentAnimationController;

  late final Animation<Offset> _upDownAnimation;

  @override
  void initState() {
    super.initState();
    _playerAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
    _opponentAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    _upDownAnimation = TweenSequence<Offset>(<TweenSequenceItem<Offset>>[
      TweenSequenceItem<Offset>(
          tween: Tween(
            begin: Offset(0, 0),
            end: Offset(0, 1),
          ),
          weight: 12),
      TweenSequenceItem<Offset>(
          tween: Tween(
            begin: Offset(0, 1),
            end: Offset(0, 0),
          ),
          weight: 12),
      TweenSequenceItem<Offset>(
          tween: Tween(
            begin: Offset(0, 0),
            end: Offset(0, 1),
          ),
          weight: 12),
      TweenSequenceItem<Offset>(
          tween: Tween(
            begin: Offset(0, 1),
            end: Offset(0, 0),
          ),
          weight: 12),
      TweenSequenceItem<Offset>(
          tween: Tween(
            begin: Offset(0, 0),
            end: Offset(0, 1),
          ),
          weight: 12),
      TweenSequenceItem<Offset>(
          tween: Tween(
            begin: Offset(0, 1),
            end: Offset(0, 0),
          ),
          weight: 12),
    ]).animate(CurvedAnimation(
        parent: _playerAnimationController, curve: Curves.linear));
  }

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
                    onChoose: (playType) {
                      BlocProvider.of<GameStateBloc>(context).add(PlayGame(
                          player1PlayType: playType,
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
                        }),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<GameStateBloc>(context).add(ResetRound());
                      _playerAnimationController.reset();
                      _opponentAnimationController.reset();
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
            print("Game State: Playing");
            _playerAnimationController.forward();
            _opponentAnimationController.forward();
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
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'You',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  AnimatedBuilder(
                                    animation: _playerAnimationController,
                                    builder: (context, value) =>
                                        SlideTransition(
                                      position: _upDownAnimation,
                                      child: Icon(
                                        mappingIcon[state.player1.playType],
                                        size: 64,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Opponent',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  AnimatedBuilder(
                                    animation: _opponentAnimationController,
                                    builder: (context, value) =>
                                        SlideTransition(
                                      position: _upDownAnimation,
                                      child: Icon(
                                        mappingIcon[state.player2.playType],
                                        size: 64,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  ActionBar(
                    onChoose: (playType) {
                      context.read<GameStateBloc>().add(PlayGame(
                          player1PlayType: playType,
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
