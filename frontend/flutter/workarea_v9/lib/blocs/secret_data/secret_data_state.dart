part of 'secret_data_bloc.dart';

sealed class SecretDataState extends Equatable {
  const SecretDataState();

  @override
  List<Object> get props => [];
}

final class SecretDataUninitialized extends SecretDataState {
  const SecretDataUninitialized();
}

final class SecretDataLoaded extends SecretDataState {
  final String secretData;
  const SecretDataLoaded({required this.secretData});
}
