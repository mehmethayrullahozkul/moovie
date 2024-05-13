import 'package:equatable/equatable.dart';

sealed class SecretDataState extends Equatable {
  const SecretDataState();

  @override
  List<Object> get props => [];
}

final class SecretDataUninitialized extends SecretDataState {
  const SecretDataUninitialized();
}

final class SecretDataLoaded extends SecretDataState {
  @override
  List<Object> get props => [secretData];
  final String secretData;
  const SecretDataLoaded({required this.secretData});
}
