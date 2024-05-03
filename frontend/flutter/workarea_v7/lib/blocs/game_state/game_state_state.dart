part of 'game_state_bloc.dart';

@immutable
sealed class GameStateState {}

final class GameStatePlaying extends GameStateState {
  final Player player1;
  final Player player2;

  GameStatePlaying({required this.player1, required this.player2});
}

final class GameStateEnd extends GameStateState {
  final Player winner;

  GameStateEnd({required this.winner});
}

final class GameStateWaiting extends GameStateState {}
