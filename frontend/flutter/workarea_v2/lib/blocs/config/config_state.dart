import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:workarea_v2/models/config/config.dart';

abstract class ConfigState extends Equatable {
  final Config? configModel;
  ConfigState
  (
    {
      this.configModel,
    }
  );
}
class ConfigLoading extends ConfigState {
  @override
  List<Object> get props => [];
}
class ConfigInitial extends ConfigState {
   ConfigInitial(
    {
       super.configModel = const Config()
    }
  );
  @override
  List<Object> get props => [];
}


class ConfigLoaded extends ConfigState {
  ConfigLoaded(
    {
      required super.configModel,
    }
  );
  @override
  List<Object> get props => [];
}

class ConfigLanguage extends ConfigState {
  @override
  List<Object> get props => [];
}
class ConfigAppTheme extends ConfigState {
  @override
  List<Object> get props => [];
}
