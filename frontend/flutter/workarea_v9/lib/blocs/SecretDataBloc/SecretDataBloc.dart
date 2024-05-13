import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:workarea_v9/Blocs/SecretDataBloc/SecretDataEvent.dart';
import 'package:workarea_v9/Blocs/SecretDataBloc/SecretDataState.dart';
import 'package:workarea_v9/Service/AuthenticationService.dart';

class SecretDataBloc extends Bloc<SecretDataEvent, SecretDataState> {
  final AuthenticationService authenticationService;
  SecretDataBloc({required this.authenticationService})
      : super(SecretDataUninitialized()) {
    on<SecretDataRequested>((event, emit) async {
      await authenticationService.getSecretData();

      emit(SecretDataLoaded(secretData: authenticationService.secretData));
    });
    on<ResetSecretData>((event, emit) async {
      emit(SecretDataUninitialized());
    });
  }
}
