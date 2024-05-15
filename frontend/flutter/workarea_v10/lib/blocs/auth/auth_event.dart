import 'package:equatable/equatable.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

final class AuthenticationStart extends AuthenticationEvent {}

final class AuthenticationApproved extends AuthenticationEvent {}

final class AuthenticationDenied extends AuthenticationEvent {}

final class AuthenticationLoginButtonPressed extends AuthenticationEvent {
  final String username;
  final String password;

  const AuthenticationLoginButtonPressed(
      {required this.username, required this.password});
}

final class AuthenticationLogoutButtonPressed extends AuthenticationEvent {}
