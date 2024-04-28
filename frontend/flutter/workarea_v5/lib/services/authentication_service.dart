const List<Map<String, String>> users = [
  {"username": "taha", "password": "123"},
  {"username": "taha", "password": "123"},
  {"username": "furkan", "password": "123"},
  {"username": "hayrullah", "password": "123"},
];

// singleton class
class AuthenticationService {
  static final AuthenticationService _instance =
      AuthenticationService._internal();

  factory AuthenticationService() {
    return _instance;
  }

  AuthenticationService._internal();

  bool authenticate({required String username, required String password}) {
    print("incoming authentication request: ${username} and ${password}");
    for (var user in users) {
      if (user["username"] == username && user["password"] == password) {
        return true;
      }
    }
    return false;
  }
}
