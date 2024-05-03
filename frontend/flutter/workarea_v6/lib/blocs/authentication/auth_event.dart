import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

final class AuthenticationStarted extends AuthenticationEvent {
  const AuthenticationStarted();
}

final class AuthenticationLoginButtonPressed extends AuthenticationEvent {
  final String username;
  final String password;

  const AuthenticationLoginButtonPressed(
      {required this.username, required this.password});
}

final class AuthenticationLogoutButtonPressed extends AuthenticationEvent {
  const AuthenticationLogoutButtonPressed();
}
