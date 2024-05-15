import 'package:flutter/material.dart';
import 'package:workarea_v10/models/user/user_credentials_model.dart';
import 'package:workarea_v10/models/user/user_model.dart';
import 'package:workarea_v10/repository/user_repository.dart';

class AuthenticationService {
  UserModel? user;
  String? secretData = "";
  final ValueNotifier<bool> auth = ValueNotifier<bool>(false);
  late final UserRepository userRepository;

  void initialize({required UserRepository userRepository}) {
    this.userRepository = userRepository;
  }

  // Singleton
  static final AuthenticationService _instance =
      AuthenticationService._internal();

  factory AuthenticationService() {
    return _instance;
  }

  AuthenticationService._internal() {
    auth.value = false;
    user = null;
    secretData = '';
  }

  Future<void> start() async {
    auth.value = false;
    secretData = '';
    auth.notifyListeners();
  }

  void dispose() {
    auth.dispose();
  }

  Future<void> signIn(
      {required String username, required String password}) async {
    user = await userRepository.signIn(username: username, password: password);
    bool authenticated;
    print("asdasd");
    if (user != null) {
      if (user!.username == username) {
        print(user!.username);
        auth.value = true;
        auth.notifyListeners();
        //  return true;
      }
    } else {
      print("False");
      auth.value = false;
      auth.notifyListeners();

      // return false;
    }
  }

  Future<void> signOut() async {
    auth.value = false;
    auth.notifyListeners();
    user = null;
    secretData = null;
  }

  Future<void> getSecretData() async {
    secretData = await userRepository.getSecretData(
        userCredentials: user!.userCredentials);
  }
}
