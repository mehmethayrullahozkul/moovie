import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AuthenticationStart extends AuthenticationEvent {}

class ButtonPressedEvent extends AuthenticationEvent {
  final String? username;
  final String? password;

  const ButtonPressedEvent(this.username, this.password);

  String getUsername() {
    return username!;
  }

  String getPassword() {
    return password!;
  }
}

class UnbuttonPressedevent extends AuthenticationEvent {}

class AuthenticationApproved extends AuthenticationEvent {}

class AuthenticationDenied extends AuthenticationEvent {}
