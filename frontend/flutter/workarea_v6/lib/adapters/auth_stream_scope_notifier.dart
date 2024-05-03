import 'dart:async';

import 'package:flutter/material.dart';
import 'package:workarea_v6/blocs/authentication/auth_bloc.dart';
import 'package:workarea_v6/blocs/authentication/auth_state.dart';
import 'package:workarea_v6/blocs/authentication/auth_bloc.dart';

/* InheritedNotifier is a widget that allows you to pass a notifier to its descendants.
  It takes a <E> class which is essentially a notifier
*/
// AuthenticationStreamNotifyScopeProvider.of(context)
//
class AuthenticationStreamNotifyScopeProvider
    extends InheritedNotifier<AuthenticationStreamNotifier> {
  final AuthenticationBloc authenticationBloc;

  AuthenticationStreamNotifyScopeProvider({
    super.key,
    required this.authenticationBloc,
    required super.child,
  }) : super(
            notifier: AuthenticationStreamNotifier(
                authenticationBloc: authenticationBloc));

  // Parent widgetlardaki en yakin BLABLA classini döndürür, bulamazsa exception atar.
  // dependOnInheritedWidgetOfExactType<BLABLA>
  static AuthenticationStreamNotifier of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<
          AuthenticationStreamNotifyScopeProvider>()!
      .notifier!;
}

class AuthenticationStreamNotifier extends ChangeNotifier {
  // STREAM ABONESI
  late final StreamSubscription<dynamic> _authSubscription;
  late AuthenticationState _oldState;
  final AuthenticationBloc authenticationBloc;

  static AuthenticationStreamNotifier? _instance;

  AuthenticationStreamNotifier._({
    required this.authenticationBloc,
  }) : _oldState = authenticationBloc.state {
    _authSubscription = authenticationBloc.stream
        .asBroadcastStream()
        .listen(((dynamic event) => {_notifyAuthListener(event)}));
  }

  factory AuthenticationStreamNotifier(
      {required AuthenticationBloc authenticationBloc}) {
    _instance ??=
        AuthenticationStreamNotifier._(authenticationBloc: authenticationBloc);
    return _instance!;
  }

  void _notifyAuthListener(dynamic event) {
    if (authenticationBloc.state != _oldState) {
      _oldState = authenticationBloc.state;
      notifyListeners();
    }
  }

  bool isSignedIn() {
    return authenticationBloc.state is AuthenticationAuthenticated;
  }
}

// Kullanıcı çıkış yaptı AuthenticatedUnauthenticated
//  Çıkış yapılmasına rağmen tekrar çıkış isteği gönderildi
// Loading screen deyken loading screen 

/*

 DATASET SAYILAR -> [1, 2, 3, 5]

 STREAM OLDUĞUNDA -> [1, 2, 3, 5]

 UYGULAMA YAZMAK ISTENIYOR DATASET DEĞİŞTİĞİNDE BUNA TEPKİ GÖSTERSİN

 DEĞİŞMESİ TAKİP EDİLECEK BİLGİ STREAM HALİNE GETİRİLİR

 VE BİR DİNLEYİCİ STREAMI DINLER VE STREAM DEĞİŞTİĞİNDE BİR TAKIM İŞLEMLER YAPAR

 YENI SAYI EKLENDI STREAME -> [1, 2, 3, 5, 7] -> DİNLEYİCİYE BİLDİRİM GİDER

 */


