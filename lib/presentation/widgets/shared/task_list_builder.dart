import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/fonts.dart';
import 'package:todo_app/core/time_functions.dart';
import 'package:todo_app/model/app_setting_model.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/notifier/app_setting_view_notifier.dart';
import 'package:todo_app/notifier/task_view_notifier.dart';
import 'package:todo_app/services/ui/dialog_services.dart';
import 'package:todo_app/services/ui/snackbar_services.dart';

class TaskListBuilder extends ConsumerWidget {
  final List<Task> tasks;
  final String? due;
  const TaskListBuilder({Key? key, required this.tasks, this.due}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppSetting appSetting = ref.watch(appSettingViewProvider);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        final task = tasks[index];

        return Dismissible(
          resizeDuration: const Duration(milliseconds: 900),
          behavior: HitTestBehavior.deferToChild,
          key: ValueKey<String>(task.id),
          background: Container(color: Colors.red),
          direction: DismissDirection.startToEnd,
          onDismissed: (DismissDirection direction) {
            ref.read(taskViewNotifierProvider.notifier).deleteTask(task: task);
            SnackbarServices.pushSnackbar(
              context,
              'Task deleted',
            );
          },
          child: GestureDetector(
            onLongPress: () => DialogServices.pushEditTaskDialog(context, task),
            child: Card(
              color: task.done ? Colors.black45 : null,
              margin: const EdgeInsets.all(2),
              borderOnForeground: false,
              child: CheckboxListTile(
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  task.description,
                  style: TextStyle(
                    color: due == 'Late'
                        ? Colors.red
                        : Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                    fontSize: appSetting.taskFontSize.toDouble(),
                    decoration: strikethroughDecoration(task.done),
                  ),
                ),
                subtitle: Text(
                  dueDateToFormattedStr(dueDate: task.due),
                  style: TextStyle(
                      fontSize: appSetting.taskFontSize.toDouble() - 1,
                      decoration: strikethroughDecoration(task.done)),
                ),
                value: task.done,
                onChanged: (bool? value) {
                  ref.read(taskViewNotifierProvider.notifier).toogleTask(task: task);
                },
              ),
            ),
          ),
        );
      },
    ); //
  }
}
