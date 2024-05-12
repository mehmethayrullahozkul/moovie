import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:workarea_v7/models/constants.dart';
import 'package:workarea_v7/models/player.dart';
import 'package:workarea_v7/services/game_service.dart';

part 'game_state_event.dart';
part 'game_state_state.dart';

class GameStateBloc extends Bloc<GameStateEvent, GameStateState> {
  final GameService gameService;
  late final ValueNotifier<GameState> gameState;
  late final ValueNotifier<GameResult> gameResult;
  late final ValueNotifier<Player> winner;
  late final VoidCallback _gameStateListener;
  GameStateBloc({required this.gameService}) : super(GameStateWaiting()) {
    gameState = GameService().gameState;
    gameResult = GameService().gameResult;
    winner = GameService().winner;

    _gameStateListener = () {
      if (gameState.value == GameState.playing) {
        add(SetGamePlaying(
            player1: gameService.player1, player2: gameService.player2));
        /* GameStatePlaying(
            player1: gameService.player1, player2: gameService.player2) */
      } else if (gameState.value == GameState.waiting) {
        emit(GameStateWaiting());
      } else if (gameState.value == GameState.end) {
        emit(GameStateEnd(winner: gameService.winner.value));
      }
    };

    gameState.addListener(_gameStateListener);

    on<GameStateEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<StartGame>((event, emit) {
      emit(GameStatePlaying(
          player1:
              HumanPlayer(name: 'Player 1', score: 0, playType: PlayType.none),
          player2: ComputerPlayer(
              name: 'Player 2', score: 0, playType: PlayType.none)));
    });
    on<ResetGame>((event, emit) {
      gameService.resetGame();
    });
    on<PlayGame>((event, emit) {
      gameService.playGame(
          player1PlayType: event.player1PlayType,
          player2PlayType: event.player2PlayType);
    });
    on<SetGamePlaying>((event, emit) {
      emit(GameStatePlaying(player1: event.player1, player2: event.player2));
    });
    on<ResetRound>((event, emit) {
      gameService.resetRound();
    });
  }
}
