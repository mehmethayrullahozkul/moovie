part of 'game_state_bloc.dart';

@immutable
sealed class GameStateEvent {}

final class StartGame extends GameStateEvent {}

final class ResetGame extends GameStateEvent {}

final class ResetRound extends GameStateEvent {}

final class PlayGame extends GameStateEvent {
  final PlayType player1PlayType;
  final PlayType player2PlayType;

  PlayGame({required this.player1PlayType, required this.player2PlayType});
}

final class SetPlayer1PlayType extends GameStateEvent {
  final PlayType playType;

  SetPlayer1PlayType({required this.playType});
}

final class SetPlayer2PlayType extends GameStateEvent {
  final PlayType playType;

  SetPlayer2PlayType({required this.playType});
}

final class EndGame extends GameStateEvent {}

final class SetGamePlaying extends GameStateEvent {
  final Player player1;
  final Player player2;

  SetGamePlaying({required this.player1, required this.player2});
}

final class SetGameResult extends GameStateEvent {
  final GameResult gameResult;

  SetGameResult({required this.gameResult});
}
