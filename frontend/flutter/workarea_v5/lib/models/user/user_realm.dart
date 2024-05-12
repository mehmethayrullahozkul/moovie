import 'package:realm/realm.dart';
import 'package:workarea_v5/common/utils.dart';

part 'user_realm.realm.dart';

@RealmModel()
class _UserRealm {
  @PrimaryKey()
  late String username;
  late String emailAddress;
  late bool isValid;
}
// dart run realm generate