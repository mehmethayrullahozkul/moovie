import 'dart:math';

import 'package:workarea_v2/blocs/renk/color_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workarea_v2/blocs/renk/color_state.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  ColorBloc() : super(ColorInitial()) {
    on<ColorChangedEvent>((event, emit) {
      emit(ColorLoading());

      if (event.color == 0) {
        emit(ColorBlack());
      } else if (event.color == 1) {
        emit(ColorWhite());
      } else if (event.color == 2) {
        emit(ColorRed());
      }
    });
  }

  /* @override
  Stream<ColorState> mapEventToState(ColorEvent event) async* {
    if(event is ColorChangedEvent){
      yield ColorLoading();
      await Future.delayed(Duration(seconds: 1));
      if(event.color == 0){
        yield ColorBlack();
      }else if(event.color == 1){
        yield ColorWhite();
      }else if(event.color == 2){
        yield ColorRed();
      }
    }
  } */
}
