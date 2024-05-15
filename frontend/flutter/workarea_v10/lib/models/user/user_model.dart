import 'package:workarea_v10/models/user/user_credentials_model.dart';
import 'package:workarea_v10/models/user/user_realm.dart';

final class UserModel {
  final String username;
  final String emailAddress;
  final bool isValid;

  UserModel._(
      {required this.username,
      required this.emailAddress,
      required this.isValid});

  UserModel._data({
    required this.username,
    required this.emailAddress,
    required this.isValid,
  });

  factory UserModel.fromRealm(UserRealm userRealm) {
    return UserModel._(
      username: userRealm.username,
      emailAddress: userRealm.emailAddress,
      isValid: userRealm.isValid,
    );
  }

  UserRealm toRealm(UserModel userModel) {
    return UserRealm(username, emailAddress, isValid);
  }

  static UserRealm createRealm({
    required String username,
    required String emailAddress,
    required bool isValid,
  }) {
    return UserRealm(username, emailAddress, true);
  }

  factory UserModel.create({
    required String username,
    required String emailAddress,
    required bool isValid,
  }) {
    return UserModel._data(
      username: username,
      emailAddress: emailAddress,
      isValid: isValid,
    );
  }
}
