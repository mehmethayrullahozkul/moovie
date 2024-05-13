import 'package:equatable/equatable.dart';

sealed class SecretDataEvent extends Equatable {
  const SecretDataEvent();

  @override
  List<Object> get props => [];
}

final class SecretDataRequested extends SecretDataEvent {
  const SecretDataRequested();
}

final class ResetSecretData extends SecretDataEvent {
  const ResetSecretData();
}
