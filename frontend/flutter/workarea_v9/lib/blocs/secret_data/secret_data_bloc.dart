import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:workarea_v9/services/authentication_service.dart';

part 'secret_data_event.dart';
part 'secret_data_state.dart';

class SecretDataBloc extends Bloc<SecretDataEvent, SecretDataState> {
  final AuthenticationService authenticationService;
  SecretDataBloc({required this.authenticationService})
      : super(SecretDataUninitialized()) {
    // TODO: implement here
  }
}
