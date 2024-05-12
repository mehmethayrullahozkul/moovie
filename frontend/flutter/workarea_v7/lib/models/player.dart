import 'package:workarea_v7/models/constants.dart';

sealed class Player {
  final String name;
  int score;
  PlayType playType;

  Player({required this.name, required this.score, required this.playType});

  void reset() {
    score = 0;
    playType = PlayType.none;
  }

  void incrementScore() {
    score++;
  }

  void setPlayType(PlayType playType) {
    this.playType = playType;
  }

  void resetPlayType() {
    playType = PlayType.none;
  }

  @override
  String toString() {
    return 'Player{name: $name, score: $score, playType: $playType}';
  }
}

class HumanPlayer extends Player {
  HumanPlayer(
      {required super.name, required super.score, required super.playType});
}

class ComputerPlayer extends Player {
  ComputerPlayer(
      {required super.name, required super.score, required super.playType});
}

class NoWinner extends Player {
  static final NoWinner _instance = NoWinner._();

  factory NoWinner() {
    return _instance;
  }

  NoWinner._() : super(name: 'No Player', score: 0, playType: PlayType.none);
}
