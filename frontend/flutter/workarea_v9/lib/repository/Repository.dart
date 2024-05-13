import 'package:dio/dio.dart';
import 'package:workarea_v9/Repository/RemoteStorage/RemoteStorage.dart';
import 'package:workarea_v9/Service/AuthenticationService.dart';

class UserRepository {
  final RemoteStorage _remoteStorage = RemoteStorage();
  static const String signInURL = "/api/login";
  static const String secretDataURL = "/api/secret-data";

  Future<User?> signIn(String username, String password) async {
    late Response response;

    try {
      response = await _remoteStorage.post(
        API.baseUrl + signInURL,
        data: {"username": username, "password": password},
      );
      if (response.statusCode == 200) {
        String username = response.data["username"];
        String mail = response.data["mail"];
        String accessToken = response.data["accessToken"];
        print(accessToken);

        User user = User(
            username: username,
            emailAddress: mail,
            credentials: Credentials(token: accessToken));
        return user;
      } else {
        return null;
      }
    } on DioError catch (e) {
      print("Error: DioError");
      print(e);
      return null;
    }
  }

  Future<String?> getSecretData(String token, String username) async {
    late Response response;

    try {
      response = await _remoteStorage.get(
        API.baseUrl + secretDataURL,
        data: {"token": token, "username": username},
      );
      if (response.statusCode == 200) {
        print("girdi");

        String secretData = response.data["data"]["secret-data"];
        print("${secretData}");

        return secretData;
      } else {
        return null;
      }
    } on DioError catch (e) {
      print("Error: DioError");
      print(e);
      return null;
    }
  }
}
