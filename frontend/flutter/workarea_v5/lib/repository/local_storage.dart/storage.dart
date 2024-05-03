import 'package:workarea_v5/models/user/user_credentials_realm.dart';
import 'package:workarea_v5/models/user/user_realm.dart';
import 'package:workarea_v5/repository/local_storage.dart/local_storage.dart';
import 'package:realm/realm.dart';

class Storage implements LocalStorage {
  late final Realm _realm;

  Storage._() {
    /* Realm.deleteRealm('default.realm'); */
    _realm = Realm(
      Configuration.local(
        [UserRealm.schema, UserCredentialsRealm.schema],
        schemaVersion: 1,
      ),
    );
  }

  static final Storage instance = Storage._();

  factory Storage() => instance;

  @override
  Iterable<M> getAll<M extends RealmObject>() {
    return _realm.all<M>();
  }

  @override
  Future<M> add<M extends RealmObject>(M item) {
    return _realm.writeAsync(() => _realm.add(item));
  }

  @override
  Future<void> addList<M extends RealmObject>(Iterable<M> items) async {
    await _realm.writeAsync(() => _realm.addAll<M>(items));
  }

  @override
  Future<M> update<M extends RealmObject>(M item) {
    return _realm.writeAsync(() => _realm.add(item, update: true));
  }

  @override
  Future<void> delete<M extends RealmObject>(M item) async {
    await _realm.writeAsync(() => _realm.delete(item));
  }

  @override
  M? find<M extends RealmObject>(Object primaryKey) {
    return _realm.find<M>(primaryKey);
  }

  @override
  void dispose() {
    _realm.close();
  }
}
