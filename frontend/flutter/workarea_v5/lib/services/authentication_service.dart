import 'package:flutter/material.dart';
import 'package:workarea_v5/models/user/user_credentials_model.dart';
import 'package:workarea_v5/models/user/user_model.dart';
import 'package:workarea_v5/repository/user_repository.dart';

class AuthenticationService {
  String name = "Ali";
  final ValueNotifier<bool> auth = ValueNotifier<bool>(false);
  late final UserRepository userRepository;

  // Singleton
  static final AuthenticationService _instance =
      AuthenticationService._internal();

  factory AuthenticationService() {
    return _instance;
  }

  AuthenticationService._internal() {
    auth.value = false;
  }

  Future<void> load({required UserRepository userRepository}) async {
    this.userRepository = userRepository;
    auth.value = false;

    bool hasLocalUser = await userRepository.hasLocalUser();

    if (!hasLocalUser) {
      auth.value = false;
      auth.notifyListeners();
      return;
    }

    UserModel? user = await userRepository.loadLocalUser();

    if (user == null) {
      auth.value = false;
      auth.notifyListeners();
      return;
    }

    UserCredentialsModel? userCredentials =
        await userRepository.loadUserCredentials(user.username);

    if (userCredentials == null) {
      auth.value = false;
      auth.notifyListeners();
      return;
    }

    bool authenticated = await userRepository.validateAccessToken(
        username: user.username, accessToken: userCredentials.accessToken);

    if (authenticated) {
      auth.value = true;
    } else {
      auth.value = false;
    }
    auth.notifyListeners();
  }

  void dispose() {
    auth.dispose();
  }

  Future<bool> signIn(
      {required String username, required String password}) async {
    bool authenticated =
        await userRepository.signIn(username: username, password: password);

    if (authenticated) {
      auth.value = true;
      auth.notifyListeners();
      return true;
    } else {
      auth.value = false;
      auth.notifyListeners();
      return false;
    }
  }
}

class AuthCapsule {
  bool isAuthenticated = false;
}


/**
 * 
 * 
 * Value Notifier:
 * 
 *  Assume you have a value to track of,
 *  To track it down and listen to changes in it: ValueNotifier<BlablaClassi>
 * 
 *  ValueNotifier<Araba> 
 * 
 * class Galeri {
 *    final ValueNotifier<Araba> hayrullahınFavorisi;
 * 
 *    hayrullahınFavorisi.value = Car(isim: "BMW");
 *    
 * 
 * 
 * }
 * 
 * 
 */