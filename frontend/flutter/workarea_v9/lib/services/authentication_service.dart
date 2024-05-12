import 'package:flutter/material.dart';
import 'package:workarea_v9/models/user/user_credentials_model.dart';
import 'package:workarea_v9/models/user/user_model.dart';
import 'package:workarea_v9/repository/user_repository.dart';

class AuthenticationService {
  UserModel? user;
  String secretData = "";
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
    // TODO: Implement the signIn method
  }

  Future<void> signOut() async {
    auth.value = false;
    auth.notifyListeners();
  }

  Future<void> getSecretData() async {
    // TODO: Implement the getSecretData method
  }
}
