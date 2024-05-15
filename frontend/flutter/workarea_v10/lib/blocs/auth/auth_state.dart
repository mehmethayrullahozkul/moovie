import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationUninitialized extends AuthenticationState {
  const AuthenticationUninitialized();
}

final class AuthenticationAuthenticated extends AuthenticationState {
  const AuthenticationAuthenticated();
}

final class AuthenticationUnauthenticated extends AuthenticationState {
  const AuthenticationUnauthenticated();
}

final class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();
}
