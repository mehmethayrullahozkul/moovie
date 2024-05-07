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
}
