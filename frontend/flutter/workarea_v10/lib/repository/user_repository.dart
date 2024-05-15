import 'package:dio/dio.dart';
import 'package:workarea_v10/models/user/user_credentials_model.dart';
import 'package:workarea_v10/models/user/user_model.dart';
import 'package:workarea_v10/repository/remote_storage.dart/remote_storage.dart';

class UserRepository {
  static const String signInURL = "/api/login";
  static const String secretDataURL = "/api/secret-data";

  late final RemoteStorage _remoteStorage;

  static Future<UserRepository> init() async {
    UserRepository dataRepository = UserRepository();
    await dataRepository.initialize();
    return dataRepository;
  }

  Future<void> initialize() async {
    _remoteStorage = RemoteStorage();
  }

  Future<UserModel?> signIn(
      {required String username, required String password}) async {
    late final Response response;
    print(username);
    try {
      response = await _remoteStorage.post(API.baseUrl + signInURL,
          data: {"username": username, "password": password});
      if (response.statusCode == 200) {
        print("girdi");
        dynamic userInformation = response.data;
        final UserModel user = UserModel.create(
            username: userInformation["username"],
            emailAddress: userInformation["mail"],
            userCredentials: UserCredentialsModel.create(
              username: userInformation["username"],
              accessToken: userInformation["accessToken"],
            ),
            isValid: userInformation["status"]);

        print(user.username);
        print("username");
        return user;
      } else {
        print('Failed to get secret data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error getting secret data: $e');
      return null;
    }
  }

  Future<String?> getSecretData(
      {required UserCredentialsModel userCredentials}) async {
    late final Response response;
    print("DATAYA GIRDI1");
    try {
      response = await _remoteStorage.get(API.baseUrl + secretDataURL, data: {
        "username": userCredentials.username,
        "token": userCredentials.accessToken
      });

      if (response.statusCode == 200) {
        print("DATAYA GIRDI");
        dynamic data = response.data;
        print(data['data']['secret-data']);
        return data['data']['secret-data'];
      } else {
        print('Failed to get secret data');
        return null;
      }
    } catch (e) {
      print('Error getting secret data: $e');
      return null;
    }
  }
}
