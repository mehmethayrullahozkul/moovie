import 'package:workarea_v5/common/utils.dart';
import 'package:workarea_v5/models/user/user_credentials_realm.dart';
import 'package:workarea_v5/models/user/user_realm.dart';

final class UserCredentialsModel {
  final String username;
  final String accessToken;
  final String refreshToken;

  UserCredentialsModel._({
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserCredentialsModel.fromRealm(UserCredentialsRealm userRealm) {
    return UserCredentialsModel._(
      username: userRealm.username,
      accessToken: userRealm.accessToken,
      refreshToken: userRealm.refreshToken,
    );
  }

  UserCredentialsRealm toRealm(UserCredentialsModel userCredentialsModel) {
    return UserCredentialsRealm(username, accessToken, refreshToken);
  }

  static UserCredentialsRealm createRealm({
    required String username,
    required String accessToken,
    required String refreshToken,
  }) {
    return UserCredentialsRealm(username, accessToken, refreshToken);
  }

  factory UserCredentialsModel.create({
    required String username,
    required String accessToken,
    required String refreshToken,
  }) {
    return UserCredentialsModel._(
      username: username,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
