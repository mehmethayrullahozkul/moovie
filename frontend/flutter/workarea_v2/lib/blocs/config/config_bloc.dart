import 'dart:math';
import 'package:workarea_v2/blocs/config/config_state.dart';
import 'package:workarea_v2/blocs/config/config_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workarea_v2/models/config/config.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  ConfigBloc() : super(ConfigInitial()) {
    on<ConfigChangedEvent>((event, emit) {
      emit(ConfigLoading());
      Config obj = Config(
          appTheme: event.config.appTheme, language: event.config.language);
      emit(ConfigLoaded(configModel: obj));
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
