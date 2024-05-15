import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:workarea_v10/models/user/user_credentials_model.dart';
import 'package:workarea_v10/services/authentication_service.dart';

part 'secret_data_event.dart';
part 'secret_data_state.dart';

class SecretDataBloc extends Bloc<SecretDataEvent, SecretDataState> {
  final AuthenticationService authenticationService;
  SecretDataBloc({required this.authenticationService})
      : super(SecretDataUninitialized()) {
    on<SecretDataRequested>((event, emit) async {
      await authenticationService.getSecretData();
      emit(SecretDataLoaded(secretData: authenticationService.secretData));
    });
    on<SecretDataInitial>((event, emit) async {
      emit(SecretDataUninitialized());
    });
  }
}
