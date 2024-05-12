import 'package:equatable/equatable.dart';
import 'package:workarea_v8/models/word_pair/word_pair_model.dart';

sealed class WordPairDataEvent extends Equatable {
  const WordPairDataEvent();

  @override
  List<Object> get props => [];
}

final class WordPairDataRequested extends WordPairDataEvent {
  final int count;

  const WordPairDataRequested({required this.count});
}

final class WordPairDataRefreshRequested extends WordPairDataEvent {
  const WordPairDataRefreshRequested();
}

final class WordPairDataCleared extends WordPairDataEvent {
  const WordPairDataCleared();
}
