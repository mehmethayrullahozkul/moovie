import 'package:flutter/material.dart';
import 'package:workarea_v7/models/constants.dart';
import 'package:workarea_v7/models/player.dart';

class GameService {
  static final GameService _instance = GameService._();

  late final Player player1;
  late final Player player2;

  factory GameService() {
    return _instance;
  }

  GameService._() {
    player1 = HumanPlayer(name: 'Player 1', score: 0, playType: PlayType.none);
    player2 =
        ComputerPlayer(name: 'Player 2', score: 0, playType: PlayType.none);
    winner = ValueNotifier<Player>(NoWinner());
    gameState = ValueNotifier<GameState>(GameState.waiting);
    gameResult = ValueNotifier<GameResult>(GameResult.draw);
  }

  late final ValueNotifier<Player> winner;

  late final ValueNotifier<GameState> gameState;

  late final ValueNotifier<GameResult> gameResult;

  void startGame() {
    gameState.value = GameState.playing;
  }

  void resetGame() {
    player1.reset();
    player2.reset();
    winner.value = NoWinner();
    gameState.value = GameState.waiting;
    gameResult.value = GameResult.draw;
  }

  void resetRound() {
    player1.setPlayType(PlayType.none);
    player2.setPlayType(PlayType.none);
    winner.value = NoWinner();
    gameState.value = GameState.waiting;
    gameResult.value = GameResult.draw;
  }

  void playGame(
      {required PlayType player1PlayType, required PlayType player2PlayType}) {
    player1.setPlayType(player1PlayType);
    player2.setPlayType(player2PlayType);

    _determineWinner();
  }

  void _determineWinner() async {
    print("checking winner for ${player1.playType} and ${player2.playType}");
    gameState.value = GameState.playing;
    await Future.delayed(const Duration(seconds: 2), () {});
    winner.value = NoWinner();

    print("determining winner");
    if (player1.playType == PlayType.none ||
        player2.playType == PlayType.none) {
      return;
    } else if (player1.playType == player2.playType) {
      gameResult.value = GameResult.draw;
    } else if (player1.playType == PlayType.rock) {
      if (player2.playType == PlayType.scissors) {
        player1.incrementScore();
        winner.value = player1;
        gameResult.value = GameResult.win;
      } else {
        player2.incrementScore();
        winner.value = player2;
        gameResult.value = GameResult.lose;
      }
    } else if (player1.playType == PlayType.paper) {
      if (player2.playType == PlayType.rock) {
        player1.incrementScore();
        winner.value = player1;
        gameResult.value = GameResult.win;
      } else {
        player2.incrementScore();
        winner.value = player2;
        gameResult.value = GameResult.lose;
      }
    } else if (player1.playType == PlayType.scissors) {
      if (player2.playType == PlayType.paper) {
        player1.incrementScore();
        winner.value = player1;
        gameResult.value = GameResult.win;
      } else {
        player2.incrementScore();
        winner.value = player2;
        gameResult.value = GameResult.lose;
      }
    }
    gameState.value = GameState.end;
  }
}
