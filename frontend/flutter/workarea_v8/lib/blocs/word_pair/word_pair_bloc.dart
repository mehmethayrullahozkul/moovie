import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workarea_v8/blocs/word_pair/word_pair_event.dart';
import 'package:workarea_v8/blocs/word_pair/word_pair_state.dart';
import 'package:workarea_v8/repository/data_repository.dart';
import 'package:workarea_v8/services/data_service.dart';

class WordPairDataBloc extends Bloc<WordPairDataEvent, WordPairDataState> {
  final DataService dataService;

  WordPairDataBloc({required this.dataService})
      : super(const WordPairDataUninitialized()) {
    on<WordPairDataRequested>((event, emit) async {
      await dataService.getRandomWordPairs(count: event.count);
      emit(WordPairDataLoaded(wordPairs: dataService.wordPairs));
    });
    on<WordPairDataRefreshRequested>((event, emit) async {
      await dataService.getRandomWordPairs(count: dataService.wordPairCount);
      emit(WordPairDataLoaded(wordPairs: dataService.wordPairs));
    });

    on<WordPairDataCleared>((event, emit) async {
      dataService.clearWordPairs();
      emit(const WordPairDataLoaded(wordPairs: []));
    });
  }
}
