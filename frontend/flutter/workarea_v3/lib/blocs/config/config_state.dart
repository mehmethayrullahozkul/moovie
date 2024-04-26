part of 'config_bloc.dart';

sealed class ConfigState extends Equatable {
  final ConfigModel? config;
  const ConfigState({this.config});
  @override
  List<Object> get props => [];
}

final class ConfigInitial extends ConfigState {}

final class ConfigLoaded extends ConfigState {
  const ConfigLoaded({required super.config});

  @override
  List<Object> get props => [super.config!];
}
