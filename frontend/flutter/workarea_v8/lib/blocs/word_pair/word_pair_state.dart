import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workarea_v8/models/word_pair/word_pair_model.dart';

sealed class WordPairDataState extends Equatable {
  const WordPairDataState();

  @override
  List<Object> get props => [];
}

final class WordPairDataUninitialized extends WordPairDataState {
  const WordPairDataUninitialized();
}

final class WordPairDataLoaded extends WordPairDataState {
  final List<WordPair> wordPairs;

  const WordPairDataLoaded({required this.wordPairs});

  @override
  List<Object> get props => [wordPairs];
}
