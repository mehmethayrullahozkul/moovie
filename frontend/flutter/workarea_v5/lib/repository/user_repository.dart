import 'package:realm/realm.dart';
import 'package:workarea_v5/models/user/user_realm.dart';
import 'package:workarea_v5/repository/local_storage.dart/storage.dart';

class UserRepository {
  late Storage storage;

  static Future<UserRepository> init() async {
    UserRepository configRepository = UserRepository();
    await configRepository.initialize();
    return configRepository;
  }

  Future<void> initialize() async {
    storage = Storage.instance;
  }

  Future<bool> isUserExists(String username) async {
    final user = storage.find<UserRealm>(username);
    return user != null;
  }

  Future<void> addUser(UserRealm user) async {
    if (await isUserExists(user.username)) {
      return;
    } else {
      await storage.add(user);
    }
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

  Future<void> addUsers(List<UserRealm> users) async {
    await storage.addList(users);
  }

  Iterable<UserRealm> getAllUsers() {
    return storage.getAll<UserRealm>();
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
