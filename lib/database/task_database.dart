// ignore_for_file: library_prefixes

import 'package:realm/realm.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:uuid/uuid.dart' as UUID;

var uuid = const UUID.Uuid();

class TaskDatabase {
  Realm realm;
  TaskDatabase(this.realm);

  RealmResults<Task> getAllTasks() => realm.all<Task>();
  RealmResults<Task> getLateTasks() {
    DateTime todayDTQuery = DateTime.now();
    return realm.query(r'due <= $0', [todayDTQuery.toIso8601String()]);
  }

  RealmResults<Task> getTodayTasks() {
    DateTime todayDT = DateTime.now();
    DateTime todayDTQueryMin = DateTime.now();
    DateTime todayDTQueryMax = DateTime(todayDT.year, todayDT.month, todayDT.day, 23, 59, 59);
    return realm.query(r'due =< $0 && due >= $1',
        [todayDTQueryMax.toIso8601String(), todayDTQueryMin.toIso8601String()]);
  }

  RealmResults<Task> getTomorrowTasks() {
    DateTime todayDT = DateTime.now();
    DateTime todayDTQueryMin = DateTime(todayDT.year, todayDT.month, todayDT.day + 1, 0, 0, 0);
    DateTime todayDTQueryMax =
        DateTime(todayDT.year, todayDT.month, todayDT.day + 1, 23, 59, 59);
    return realm.query(r'due <= $0 && due >= $1',
        [todayDTQueryMax.toIso8601String(), todayDTQueryMin.toIso8601String()]);
  }

  RealmResults<Task> getThisWeekTasks() {
    DateTime todayDT = DateTime.now();
    DateTime todayDTQueryMin = DateTime(todayDT.year, todayDT.month, todayDT.day + 2, 0, 0, 0);
    DateTime todayDTQueryMax =
        DateTime(todayDT.year, todayDT.month, todayDT.day + 7, 23, 59, 59);
    return realm.query(r'due <= $0 && due >= $1',
        [todayDTQueryMax.toIso8601String(), todayDTQueryMin.toIso8601String()]);
  }

  RealmResults<Task> getNextWeekTasks() {
    DateTime todayDT = DateTime.now();
    DateTime todayDTQueryMin =
        DateTime(todayDT.year, todayDT.month, todayDT.day + 7 + 1, 0, 0, 0);
    DateTime todayDTQueryMax =
        DateTime(todayDT.year, todayDT.month, todayDT.day + 7 + 1 + 7, 23, 59, 59);
    return realm.query(r'due <= $0 && due >= $1',
        [todayDTQueryMax.toIso8601String(), todayDTQueryMin.toIso8601String()]);
  }

  RealmResults<Task> getThisMonthTasks() {
    DateTime todayDT = DateTime.now();
    DateTime todayDTQueryMin =
        DateTime(todayDT.year, todayDT.month, todayDT.day + 7 + 1 + 7 + 1, 0, 0, 0);
    DateTime todayDTQueryMax =
        DateTime(todayDT.year, todayDT.month, todayDT.day + 7 + 1 + 7 + 1 + 21, 23, 59, 59);
    return realm.query(r'due <= $0 && due >= $1',
        [todayDTQueryMax.toIso8601String(), todayDTQueryMin.toIso8601String()]);
  }

  RealmResults<Task> getLaterTasks() {
    DateTime todayDT = DateTime.now();
    DateTime todayDTQuery =
        DateTime(todayDT.year, todayDT.month, todayDT.day + 7 + 1 + 7 + 1 + 21 + 1, 0, 0, 0);
    return realm.query(r'due >= $0', [todayDTQuery.toIso8601String()]);
  }

  void createTask({
    required String description,
    required String due,
    required bool done,
  }) {
    realm.write(() {
      realm.add<Task>(Task(uuid.v4(), description, due, done));
    });
  }

  void updateTask({
    required Task task,
    required String description,
    required String due,
  }) {
    realm.write(() {
      task.description = description;
      task.due = due;
    });
  }

  void deleteTask({required Task task}) {
    realm.write(() {
      realm.delete(task);
    });
  }

  void clearTask() {
    realm.write(() {
      realm.deleteAll<Task>();
    });
  }

  void toogleTask({required Task task}) {
    realm.write(() {
      task.done = !task.done;
    });
  }
}
