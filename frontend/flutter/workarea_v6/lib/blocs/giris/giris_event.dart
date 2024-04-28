import 'package:equatable/equatable.dart';

sealed class GirisEvent extends Equatable {
  const GirisEvent();

  @override
  List<Object> get props => [];
}

final class GirisStart extends GirisEvent {}

final class GirisApproved extends GirisEvent {}

final class GirisDenied extends GirisEvent {}

final class GirisButtonPressed extends GirisEvent {
  final String username;
  final String password;

  const GirisButtonPressed(
      {required this.username, required this.password});
}

final class CikisButtonPressed extends GirisEvent {}
