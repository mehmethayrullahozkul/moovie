part of 'name_bloc.dart';

sealed class NameState extends Equatable {
  const NameState({this.name});
  final String? name;

  @override
  List<Object> get props => [];
}

final class NameInitial extends NameState {
  const NameInitial({super.name = "İsim Yok"});
}

final class NameLoading extends NameState {}

final class NameLoaded extends NameState {
  const NameLoaded({required super.name});
}
