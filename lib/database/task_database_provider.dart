import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:todo_app/database/task_database.dart';
import 'package:todo_app/model/task_model.dart';

final configurationInstanceProvider = Provider<Configuration>((ref) {
  return Configuration.local([Task.schema]);
});

final realmInstanceProvider = Provider<Realm>((ref) {
  final Configuration config = ref.watch(configurationInstanceProvider);
  final Realm realm = Realm(config);
  return realm;
});

//Main task database
final taskDatabaseProvider = Provider<TaskDatabase>((ref) {
  final Realm realm = ref.watch(realmInstanceProvider);
  final TaskDatabase taskDb = TaskDatabase(realm);
  return taskDb;
});
