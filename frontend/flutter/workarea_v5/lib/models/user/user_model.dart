import 'package:workarea_v5/common/utils.dart';
import 'package:workarea_v5/models/user/user_realm.dart';

final class UserModel {
  final UserRealm _userRealm;

  UserModel._(this._userRealm);

  UserModel._data({
    required String username,
    required String password,
    required String emailAddress,
    required bool isValid,
  }) : _userRealm = UserRealm(
            username, Utils.generateSHA256(password), emailAddress, true);

  factory UserModel.fromRealm(UserRealm userRealm) {
    return UserModel._(userRealm);
  }

  static UserRealm toRealm(UserModel userModel) {
    return userModel._userRealm;
  }

  static UserRealm createRealm({
    required String username,
    required String password,
    required String emailAddress,
    required bool isValid,
  }) {
    return UserRealm(
        username, Utils.generateSHA256(password), emailAddress, true);
  }

  factory UserModel.create({
    required String username,
    required String password,
    required String emailAddress,
    required bool isValid,
  }) {
    return UserModel._data(
      username: username,
      password: password,
      emailAddress: emailAddress,
      isValid: isValid,
    );
  }
}
