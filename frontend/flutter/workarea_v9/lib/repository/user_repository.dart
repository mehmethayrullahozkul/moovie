import 'dart:html';

import 'package:dio/dio.dart';
import 'package:workarea_v9/models/user/user_credentials_model.dart';
import 'package:workarea_v9/models/user/user_model.dart';
import 'package:workarea_v9/repository/remote_storage.dart/remote_storage.dart';

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

    // TODO: Implement the signIn method
  }

  Future<String?> getSecretData(
      {required UserCredentialsModel userCredentials}) async {
    late final Response response;

    // TODO: Implement the getSecretData method
  }
}
