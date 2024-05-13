import 'package:flutter/widgets.dart';
import 'package:workarea_v9/Repository/Repository.dart';

class User {
  late final String? username;
  late final String? emailAddress;
  Credentials credentials;
  User(
      {required this.username,
      required this.emailAddress,
      required this.credentials});
}

class Credentials {
  late final String token;
  Credentials({required this.token});
}

class AuthenticationService {
  late final UserRepository userRepository;
  User? user;
  String secretData = "";
  final ValueNotifier<bool> auth = ValueNotifier<bool>(false);

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

  Future<void> signIn(String username, String password) async {
    User? user2 = await userRepository.signIn(username, password);
    if (user2 == null) {
      auth.value = false;
      auth.notifyListeners();
      user = null;
      print("kral adam hayru");
    } else {
      auth.value = true;
      auth.notifyListeners();
      print("kral olmayan adam hayru");
      user = user2;
    }
  }

  Future<void> signOut() async {
    auth.value = false;
    auth.notifyListeners();
    user = null;
    secretData = '';
  }

  Future<void> getSecretData() async {
    String? value = await userRepository.getSecretData(
        user!.credentials.token, user!.username!);

    if (value != null) {
      secretData = value;
    }
  }
}
