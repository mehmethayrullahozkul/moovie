import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workarea_v6/blocs/giris/giris_event.dart';
import 'package:workarea_v6/blocs/giris/giris_state.dart';
import 'package:workarea_v6/services/service.dart';

class GirisBloc extends Bloc<GirisEvent, GirisState> {
  GirisBloc() : super(const GirisUninitialized()) {
    on<GirisStart>((event, emit) {
      // Check the authentication

      emit(GirisUninitialized());
    });
    on<GirisApproved>((event, emit) {
      emit(GirisYapildi());
    });
    on<GirisDenied>((event, emit) {
      emit(GirisYapilmadi());
    });
    on<GirisButtonPressed>((event, emit) async {
      emit(const GirisYapiliyor());

      await Future.delayed(const Duration(seconds: 2));
      bool dogrula = GirisService()
          .dogru(username: event.username, password: event.password);
      if (dogrula) {
        emit(const GirisYapildi());
      } else {
        emit(const GirisYapilmadi());
      }
    });
    on<CikisButtonPressed>((event, emit) {
      emit(const GirisYapilmadi());
    });
  }
}
