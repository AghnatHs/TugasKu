import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/services/tasks/task_services.dart';

final taskViewNotifierProvider =
    StateNotifierProvider<TaskViewNotifier, List<Task>>((Ref ref) {
  TaskViewNotifier taskView = TaskViewNotifier(ref);
  taskView.init();
  return taskView;
});

final StateProvider<int> lateTaskCounterProvider = StateProvider<int>((Ref ref) {
  ref.watch(taskViewNotifierProvider);
  return ref
      .read(taskViewNotifierProvider.notifier)
      .lateTasks()
      .length;
});

final StateProvider<int> lateTaskUncompletedCounterProvider = StateProvider<int>((Ref ref) {
  ref.watch(taskViewNotifierProvider);
  return ref
      .read(taskViewNotifierProvider.notifier)
      .lateTasks()
      .where((task) => task.done == false)
      .length;
});

final StateProvider<int> todayTaskCounterProvider = StateProvider<int>((Ref ref) {
  ref.watch(taskViewNotifierProvider);
  return ref
      .read(taskViewNotifierProvider.notifier)
      .todayTasks()
      .length;
});

final StateProvider<int> tomorrowTaskCounterProvider = StateProvider<int>((Ref ref) {
  ref.watch(taskViewNotifierProvider);
  return ref
      .read(taskViewNotifierProvider.notifier)
      .tomorrowTasks()
      .length;
});

final StateProvider<double> completedTaskPercentageProvider = StateProvider<double>((Ref ref) {
  ref.watch(taskViewNotifierProvider);
  return ref.read(taskViewNotifierProvider.notifier).completedPercentage;
});

final StateProvider<int> completedTaskCounterProvider = StateProvider<int>((Ref ref) {
  ref.watch(taskViewNotifierProvider);
  return ref
      .read(taskViewNotifierProvider.notifier)
      .allTasks()
      .where((task) => task.done == true)
      .length;
});

class TaskViewNotifier extends StateNotifier<List<Task>> {
  final Ref ref;
  TaskViewNotifier(this.ref) : super([]);

  double get completedPercentage {
    List<Task> tList = state;
    int total = tList.length;
    int completed = 0;
    for (Task task in tList) {
      if (task.done) completed++;
    }
    return (completed / total) * 100;
  }

  void init() {
    state = TaskServices.allTasks(ref: ref).toList();
  }

  void createTask({
    required String description,
    required String due,
    required bool done,
  }) {
    TaskServices.create(description: description, due: due, done: done, ref: ref);
    state = TaskServices.allTasks(ref: ref).toList();
  }

  void updateTask({
    required Task task,
    required String description,
    required String due,
  }) {
    TaskServices.update(task: task, description: description, due: due, ref: ref);
    state = TaskServices.allTasks(ref: ref).toList();
  }

  void deleteTask({required Task task}) {
    TaskServices.delete(task: task, ref: ref);
    state = TaskServices.allTasks(ref: ref).toList();
  }

  void toogleTask({required Task task}) {
    TaskServices.toogle(task: task, ref: ref);
    state = TaskServices.allTasks(ref: ref).toList();
  }

  List<Task> allTasks() {
    return TaskServices.allTasks(ref: ref).toList();
  }

  List<Task> lateTasks() {
    return TaskServices.lateTasks(ref: ref).toList();
  }

  List<Task> todayTasks() {
    return TaskServices.todayTasks(ref: ref).toList();
  }

  List<Task> tomorrowTasks() {
    return TaskServices.tomorrowTasks(ref: ref).toList();
  }

  List<Task> thisWeekTasks() {
    return TaskServices.thisWeekTasks(ref: ref).toList();
  }

  List<Task> nextWeekTasks() {
    return TaskServices.nextWeekTasks(ref: ref).toList();
  }

  List<Task> thisMonthTasks() {
    return TaskServices.thisMonthTasks(ref: ref).toList();
  }

  List<Task> laterTasks() {
    return TaskServices.laterTasks(ref: ref).toList();
  }
}
