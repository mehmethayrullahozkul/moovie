final class UserCredentialsModel {
  final String username;
  final String accessToken;
  final String refreshToken;

  UserCredentialsModel._({
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  });

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

  factory UserCredentialsModel.fromJSON(Map<String, dynamic> json) {
    return UserCredentialsModel._(
      username: json['username'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
