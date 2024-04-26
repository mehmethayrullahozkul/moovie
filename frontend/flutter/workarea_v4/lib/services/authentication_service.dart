const List<Map<String, String>> users = [
  {"username": "hayrullah", "password": "123"},
  {"username": "furkan", "password": "123"},
];

class AuthenticationService {
  static final AuthenticationService _instance =
      AuthenticationService._internal();

  factory AuthenticationService() {
    return _instance;
  }

  AuthenticationService._internal();

  bool authenticate(String username, String password) {
    for (var user in users) {
      if (user["username"] == username && user["password"] == password) {
        return true;
      }
    }
    return false;
  }
}
