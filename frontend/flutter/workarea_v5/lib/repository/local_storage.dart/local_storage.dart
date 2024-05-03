import 'package:realm/realm.dart';

abstract interface class LocalStorage {
  Iterable<M> getAll<M extends RealmObject>();

  Future<M> add<M extends RealmObject>(M item);

  Future<void> addList<M extends RealmObject>(Iterable<M> items);

  Future<M> update<M extends RealmObject>(M item);

  Future<void> delete<M extends RealmObject>(M item);

  M? find<M extends RealmObject>(Uuid primaryKey);

  void dispose();
}

/*
 KULLANICIYA ÖZEL, SİZE DEĞER VERİYORUZ
 FİLM,

*/