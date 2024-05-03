// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_realm.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class UserRealm extends _UserRealm
    with RealmEntity, RealmObjectBase, RealmObject {
  UserRealm(
    String username,
    String emailAddress,
    bool isValid,
  ) {
    RealmObjectBase.set(this, 'username', username);
    RealmObjectBase.set(this, 'emailAddress', emailAddress);
    RealmObjectBase.set(this, 'isValid', isValid);
  }

  UserRealm._();

  @override
  String get username =>
      RealmObjectBase.get<String>(this, 'username') as String;
  @override
  set username(String value) => RealmObjectBase.set(this, 'username', value);

  @override
  String get emailAddress =>
      RealmObjectBase.get<String>(this, 'emailAddress') as String;
  @override
  set emailAddress(String value) =>
      RealmObjectBase.set(this, 'emailAddress', value);

  @override
  bool get isValid => RealmObjectBase.get<bool>(this, 'isValid') as bool;
  @override
  set isValid(bool value) => RealmObjectBase.set(this, 'isValid', value);

  @override
  Stream<RealmObjectChanges<UserRealm>> get changes =>
      RealmObjectBase.getChanges<UserRealm>(this);

  @override
  UserRealm freeze() => RealmObjectBase.freezeObject<UserRealm>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'username': username.toEJson(),
      'emailAddress': emailAddress.toEJson(),
      'isValid': isValid.toEJson(),
    };
  }

  static EJsonValue _toEJson(UserRealm value) => value.toEJson();
  static UserRealm _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'username': EJsonValue username,
        'emailAddress': EJsonValue emailAddress,
        'isValid': EJsonValue isValid,
      } =>
        UserRealm(
          fromEJson(username),
          fromEJson(emailAddress),
          fromEJson(isValid),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(UserRealm._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, UserRealm, 'UserRealm', [
      SchemaProperty('username', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('emailAddress', RealmPropertyType.string),
      SchemaProperty('isValid', RealmPropertyType.bool),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
