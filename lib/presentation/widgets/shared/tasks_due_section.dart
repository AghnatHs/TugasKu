import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/fonts.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/presentation/widgets/shared/task_list_builder.dart';

class TaskDueSection extends ConsumerWidget {
  final String dueTitle;
  final List<Task> tasks;
  const TaskDueSection({Key? key, required this.dueTitle, required this.tasks})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return tasks.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(dueTitle,
                  style: GFont.monsterratTitle2.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 19,
                      color: dueTitle == 'Late' ? Colors.red : null)),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: TaskListBuilder(tasks: tasks, due: dueTitle,),
              ),
            ],
          );
  }
}
