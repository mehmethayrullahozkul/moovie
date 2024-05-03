import 'package:equatable/equatable.dart';

sealed class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

final class AuthenticationUninitialized extends AuthenticationState {}

final class AuthenticationLoading extends AuthenticationState {}

final class AuthenticationAuthenticated extends AuthenticationState {}

final class AuthenticationUnauthenticated extends AuthenticationState {}
