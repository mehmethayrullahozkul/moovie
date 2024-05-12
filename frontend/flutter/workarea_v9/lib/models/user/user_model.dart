import 'package:workarea_v9/models/user/user_credentials_model.dart';

final class UserModel {
  final String username;
  final String emailAddress;
  final UserCredentialsModel userCredentials;
  final bool isValid;

  UserModel._(
      {required this.username,
      required this.emailAddress,
      required this.userCredentials,
      required this.isValid});

  factory UserModel.create({
    required String username,
    required String emailAddress,
    required UserCredentialsModel userCredentials,
    required bool isValid,
  }) {
    return UserModel._(
      username: username,
      emailAddress: emailAddress,
      userCredentials: userCredentials,
      isValid: isValid,
    );
  }

  factory UserModel.fromJSON(Map<String, dynamic> json) {
    return UserModel._(
      username: json['username'],
      emailAddress: json['emailAddress'],
      userCredentials: UserCredentialsModel.create(
        username: json['userCredentials']['username'],
        accessToken: json['userCredentials']['accessToken'],
        refreshToken: json['userCredentials']['refreshToken'],
      ),
      isValid: json['isValid'],
    );
  }
}
