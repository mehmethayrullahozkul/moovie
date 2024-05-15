final class UserCredentialsModel {
  final String username;
  final String accessToken;

  UserCredentialsModel._({
    required this.username,
    required this.accessToken,
  
  });

  factory UserCredentialsModel.create({
    required String username,
    required String accessToken,
  }) {
    return UserCredentialsModel._(
      username: username,
      accessToken: accessToken,
    );
  }
}
