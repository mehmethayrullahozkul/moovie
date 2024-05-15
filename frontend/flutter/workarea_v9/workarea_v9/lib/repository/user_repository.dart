import 'package:dio/dio.dart';
import 'package:workarea_v9/models/user/user_credentials_model.dart';
import 'package:workarea_v9/models/user/user_model.dart';
import 'package:workarea_v9/repository/remote_storage.dart/remote_storage.dart';

class UserRepository {
  static const String signInURL = "/api/login";
  static const String secretDataURL = "/api/secret";

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
          body: {"username": username, "password": password}, headers: null);
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
      e.toString();
      print('Error getting secret data: $e');
      return null;
    }
  }

  Future<String?> getSecretData(
      {required UserCredentialsModel userCredentials}) async {
    late final Response response;
    try {
      response = await _remoteStorage.get(
        API.baseUrl + '/api/users/${userCredentials.username}/secret',
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": userCredentials.accessToken
        },
        body: {
          "username": userCredentials.username,
          "token": userCredentials.accessToken
        },
      );

      if (response.statusCode == 200) {
        print("DATAYA GIRDI");
        dynamic data = response.data;
        print(data['secret']);
        return data['secret'];
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
