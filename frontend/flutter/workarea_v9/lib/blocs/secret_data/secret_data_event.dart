part of 'secret_data_bloc.dart';

sealed class SecretDataEvent extends Equatable {
  const SecretDataEvent();

  @override
  List<Object> get props => [];
}

final class SecretDataRequested extends SecretDataEvent {
  const SecretDataRequested();
}
