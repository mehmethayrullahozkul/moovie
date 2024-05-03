import 'package:realm/realm.dart';
import 'package:workarea_v5/common/utils.dart';

part 'user_credentials_realm.realm.dart';

@RealmModel()
class _UserCredentialsRealm {
  @PrimaryKey()
  late String username;
  late String accessToken;
  late String refreshToken;
}
