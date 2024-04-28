const List<Map<String, String>> users = [
  {"username": "TAHA TAŞŞAK", "password": "123"},
  {"username": "TAHA", "password": "123"},
  {"username": "furkan", "password": "123"},
  {"username": "hayrullah", "password": "123"},
];

class GirisService {
  static final GirisService _instance =
      GirisService._internal();

  factory GirisService() {
    return _instance;
  }

  GirisService._internal();

  bool dogru({required String username, required String password}) {
    print("gelen giris istegi: ${username} and ${password}");
    for (var user in users) {
      if (user["username"] == username && user["password"] == password) {
        return true;
      }
    }
    return false;
  }
}