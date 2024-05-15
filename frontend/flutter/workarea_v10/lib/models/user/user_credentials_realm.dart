import 'package:realm/realm.dart';

part 'user_credentials_realm.realm.dart';

@RealmModel()
class _UserCredentialsRealm {
  @PrimaryKey()
  late String username;
  late String accessToken;
  late String refreshToken;
}
