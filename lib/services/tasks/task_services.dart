import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:todo_app/database/task_database_provider.dart';
import 'package:todo_app/model/task_model.dart';

//Communicating CRUD to get a data from database
//avoid direct interaction with database
class TaskServices {
  static void create({
    required String description,
    required String due,
    required bool done,
    required Ref ref,
  }) {
    ref.watch(taskDatabaseProvider).createTask(
          description: description,
          due: due,
          done: done,
        );
  }

  static void update({
    required Task task,
    required String description,
    required String due,
    required Ref ref,
  }) {
    ref.watch(taskDatabaseProvider).updateTask(
          task: task,
          description: description,
          due: due,
        );
  }

  static void delete({required Task task, required Ref ref}) {
    ref.watch(taskDatabaseProvider).deleteTask(task: task);
  }

  static void clearAll({required Ref ref}) {
    ref.watch(taskDatabaseProvider).clearTask();
  }

  static void toogle({required Task task, required Ref ref}) {
    ref.watch(taskDatabaseProvider).toogleTask(task: task);
  }

  static RealmResults<Task> noDueTasks({required Ref ref}) {
    return ref.watch(taskDatabaseProvider).getNoDueTask();
  }

  static RealmResults<Task> allTasks({required Ref ref}) {
    return ref.watch(taskDatabaseProvider).getAllTasks();
  }

  static RealmResults<Task> lateTasks({required Ref ref}) {
    return ref.watch(taskDatabaseProvider).getLateTasks();
  }

  static RealmResults<Task> todayTasks({required Ref ref}) {
    return ref.watch(taskDatabaseProvider).getTodayTasks();
  }

  static RealmResults<Task> tomorrowTasks({required Ref ref}) {
    return ref.watch(taskDatabaseProvider).getTomorrowTasks();
  }

  static RealmResults<Task> thisWeekTasks({required Ref ref}) {
    return ref.watch(taskDatabaseProvider).getThisWeekTasks();
  }

  static RealmResults<Task> nextWeekTasks({required Ref ref}) {
    return ref.watch(taskDatabaseProvider).getNextWeekTasks();
  }

  static RealmResults<Task> thisMonthTasks({required Ref ref}) {
    return ref.watch(taskDatabaseProvider).getThisMonthTasks();
  }

  static RealmResults<Task> laterTasks({required Ref ref}) {
    return ref.watch(taskDatabaseProvider).getLaterTasks();
  }
}
