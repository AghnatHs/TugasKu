import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/fonts.dart';
import 'package:todo_app/core/time_functions.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/notifier/task_view_notifier.dart';
import 'package:todo_app/services/ui/dialog_services.dart';
import 'package:todo_app/services/ui/snackbar_services.dart';

class TaskListBuilder extends ConsumerWidget {
  final List<Task> tasks;
  final String? due;
  const TaskListBuilder({Key? key, required this.tasks, this.due}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        final task = tasks[index];

        return Dismissible(
          behavior: HitTestBehavior.translucent,
          key: ValueKey<String>(task.id),
          background: Container(color: Colors.red),
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
              color: task.done ? Colors.black : null,
              margin: const EdgeInsets.all(2),
              borderOnForeground: false,
              child: CheckboxListTile(
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  task.description,
                  style: TextStyle(
                    color: due == 'Late' ? Colors.red : null,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    decoration: strikethroughDecoration(task.done),
                  ),
                ),
                subtitle: Text(
                  dueDateToFormattedStr(dueDate: task.due),
                  style:
                      TextStyle(fontSize: 13, decoration: strikethroughDecoration(task.done)),
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
