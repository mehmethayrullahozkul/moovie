part of 'name_bloc.dart';

sealed class NameEvent extends Equatable {
  const NameEvent();

  @override
  List<Object> get props => [];
}

final class NameChanged extends NameEvent {
  final String name;

  const NameChanged({required this.name});
}
