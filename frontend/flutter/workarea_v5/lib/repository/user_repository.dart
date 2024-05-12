import 'package:dio/dio.dart';
import 'package:realm/realm.dart';
import 'package:workarea_v5/models/user/user_credentials_model.dart';
import 'package:workarea_v5/models/user/user_credentials_realm.dart';
import 'package:workarea_v5/models/user/user_model.dart';
import 'package:workarea_v5/models/user/user_realm.dart';
import 'package:workarea_v5/repository/local_storage.dart/storage.dart';
import 'package:workarea_v5/services/request_service.dart';

class UserRepository {
  late Storage storage;
  final RequestService _request = RequestService();

  static Future<UserRepository> init() async {
    UserRepository userRepository = UserRepository();
    await userRepository.initialize();
    return userRepository;
  }

  Future<void> initialize() async {
    storage = Storage.instance;
  }

  Future<bool> hasLocalUser() async {
    final users = storage.getAll<UserRealm>();
    return users.isNotEmpty;
  }

  Future<bool> isUserExists(String username) async {
    final user = storage.find<UserRealm>(username);
    return user != null;
  }

  Future<UserModel?> loadLocalUser() async {
    final users = storage.getAll<UserRealm>();
    if (users.isEmpty) {
      return null;
    }
    return UserModel.fromRealm(users.first);
  }

  Future<void> saveUser(UserRealm user) async {
    if (await isUserExists(user.username)) {
      return;
    } else {
      await storage.add(user);
    }
  }

  Future<void> saveUserCredentials(UserCredentialsRealm userCredentials) async {
    if (await hasUserLocalUserCredentials(userCredentials.username)) {
      return;
    } else {
      await storage.add(userCredentials);
    }
  }

  Future<UserCredentialsModel?> loadUserCredentials(String username) async {
    UserCredentialsRealm? userCredentialsRealm =
        storage.find<UserCredentialsRealm>(username);
    if (userCredentialsRealm == null) {
      return null;
    }
    return UserCredentialsModel.fromRealm(userCredentialsRealm!);
  }

  Future<void> updateUserCredentials(
      UserCredentialsRealm userCredentials) async {
    await storage.update(userCredentials);
  }

  Future<bool> hasLocalUserCredentials() async {
    final users = storage.getAll<UserCredentialsRealm>();
    return users.isNotEmpty;
  }

  Future<bool> hasUserLocalUserCredentials(String username) async {
    final user = storage.find<UserCredentialsRealm>(username);
    return user != null;
  }

  Future<UserRealm?> getUser(String username) async {
    return storage.find<UserRealm>(username);
  }

  Future<void> updateUser(UserRealm user) async {
    await storage.update(user);
  }

  Future<void> deleteUser(UserRealm user) async {
    await storage.delete(user);
  }

  Future<void> dispose() async {
    storage.dispose();
  }

  Future<void> saveUsers(List<UserRealm> users) async {
    await storage.addList(users);
  }

  Iterable<UserRealm> getAllUsers() {
    return storage.getAll<UserRealm>();
  }

  Future<bool> signIn(
      {required String username, required String password}) async {
    late final Response response;

    try {
      response = await _request.post(API.signInUrl,
          data: {"username": username, "password": password});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException {
      return false;
    }
  }

  Future<bool> validateAccessToken(
      {required String username, required String accessToken}) async {
    late final Response response;

    //final token = await _storage.read(key: 'token');
    try {
      response = await _request.post(API.authTokenUrl,
          data: {"username": username, "token": accessToken});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException {
      return false;
    }
  }

  Iterable<UserCredentialsRealm> getAllUserCredentials() {
    return storage.getAll<UserCredentialsRealm>();
  }

  Future<void> deleteUsers(List<UserRealm> users) async {
    for (final user in users) {
      await storage.delete(user);
    }
  }

  Future<void> deleteAllUsers() async {
    final users = storage.getAll<UserRealm>();
    for (final user in users) {
      await storage.delete(user);
    }
  }
}
