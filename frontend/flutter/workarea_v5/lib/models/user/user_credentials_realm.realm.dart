// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_credentials_realm.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class UserCredentialsRealm extends _UserCredentialsRealm
    with RealmEntity, RealmObjectBase, RealmObject {
  UserCredentialsRealm(
    String username,
    String accessToken,
    String refreshToken,
  ) {
    RealmObjectBase.set(this, 'username', username);
    RealmObjectBase.set(this, 'accessToken', accessToken);
    RealmObjectBase.set(this, 'refreshToken', refreshToken);
  }

  UserCredentialsRealm._();

  @override
  String get username =>
      RealmObjectBase.get<String>(this, 'username') as String;
  @override
  set username(String value) => RealmObjectBase.set(this, 'username', value);

  @override
  String get accessToken =>
      RealmObjectBase.get<String>(this, 'accessToken') as String;
  @override
  set accessToken(String value) =>
      RealmObjectBase.set(this, 'accessToken', value);

  @override
  String get refreshToken =>
      RealmObjectBase.get<String>(this, 'refreshToken') as String;
  @override
  set refreshToken(String value) =>
      RealmObjectBase.set(this, 'refreshToken', value);

  @override
  Stream<RealmObjectChanges<UserCredentialsRealm>> get changes =>
      RealmObjectBase.getChanges<UserCredentialsRealm>(this);

  @override
  UserCredentialsRealm freeze() =>
      RealmObjectBase.freezeObject<UserCredentialsRealm>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'username': username.toEJson(),
      'accessToken': accessToken.toEJson(),
      'refreshToken': refreshToken.toEJson(),
    };
  }

  static EJsonValue _toEJson(UserCredentialsRealm value) => value.toEJson();
  static UserCredentialsRealm _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'username': EJsonValue username,
        'accessToken': EJsonValue accessToken,
        'refreshToken': EJsonValue refreshToken,
      } =>
        UserCredentialsRealm(
          fromEJson(username),
          fromEJson(accessToken),
          fromEJson(refreshToken),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(UserCredentialsRealm._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.realmObject, UserCredentialsRealm, 'UserCredentialsRealm', [
      SchemaProperty('username', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('accessToken', RealmPropertyType.string),
      SchemaProperty('refreshToken', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
