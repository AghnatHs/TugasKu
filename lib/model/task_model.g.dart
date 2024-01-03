// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Task extends _Task with RealmEntity, RealmObjectBase, RealmObject {
  Task(
    String id,
    String description,
    String due,
    bool done,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'due', due);
    RealmObjectBase.set(this, 'done', done);
  }

  Task._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  String get due => RealmObjectBase.get<String>(this, 'due') as String;
  @override
  set due(String value) => RealmObjectBase.set(this, 'due', value);

  @override
  bool get done => RealmObjectBase.get<bool>(this, 'done') as bool;
  @override
  set done(bool value) => RealmObjectBase.set(this, 'done', value);

  @override
  Stream<RealmObjectChanges<Task>> get changes =>
      RealmObjectBase.getChanges<Task>(this);

  @override
  Task freeze() => RealmObjectBase.freezeObject<Task>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Task._);
    return const SchemaObject(ObjectType.realmObject, Task, 'Task', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('due', RealmPropertyType.string),
      SchemaProperty('done', RealmPropertyType.bool),
    ]);
  }
}
