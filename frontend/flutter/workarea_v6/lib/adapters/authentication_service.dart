const List<Map<String, String>> users = [
  {"username": "TAHA TAŞŞAK", "password": "123"},
  {"username": "1", "password": "1"},
  {"username": "furkan", "password": "123"},
  {"username": "hayrullah", "password": "123"},
];

class AuthenticationService {
  static final AuthenticationService authenticationService =
      AuthenticationService._();

  AuthenticationService._() {}

  factory AuthenticationService() {
    return authenticationService;
  }

  static bool authenticate(
      {required String username, required String password}) {
    for (var user in users) {
      if (username == user["username"] && password == user["password"]) {
        return true;
      }
    }
    return false;
  }
}
