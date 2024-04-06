import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/fonts.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/notifier/task_view_notifier.dart';
import 'package:todo_app/presentation/widgets/shared/dialog_cancel_button.dart';
import 'package:todo_app/services/ui/snackbar_services.dart';

class EditTaskDialog extends ConsumerStatefulWidget {
  final Task task;
  const EditTaskDialog({Key? key, required this.task}) : super(key: key);

  @override
  ConsumerState<EditTaskDialog> createState() => EditTaskDialogState();
}

class EditTaskDialogState extends ConsumerState<EditTaskDialog> {
  Task? task;
  TextEditingController taskNameController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  String dueDate = 'none';
  String dueDateDefault = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    0,
    0,
    1,
  ).toIso8601String();

  @override
  void initState() {
    super.initState();
    task = widget.task;
    taskNameController.text = widget.task.description;
    dueDateController.text = widget.task.due;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Edit a task",
      ),
      titleTextStyle: GFont.dialogTitle.copyWith(color: Theme.of(context).colorScheme.primary),
      insetPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Task Name Field
          TextFormField(
            controller: taskNameController,
            decoration: const InputDecoration(
              hintText: 'Enter task name',
              labelText: 'Task Name',
            ),
            onChanged: (String? value) => setState(() {}),
          ),
          //Due Date Field
          Row(
            children: [
              Flexible(
                child: TextFormField(
                  enabled: false,
                  controller: dueDateController,
                  decoration: const InputDecoration(
                    hintText: 'Due Date not set',
                    labelText: 'Due Date',
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  DateTime? initialDate = DateTime.tryParse(dueDateController.text);

                  DateTime datetimeNow = DateTime.now();
                  DateTime firstDate = DateTime(datetimeNow.year, datetimeNow.month);

                  DateTime? dateSelected = await showDatePicker(
                    context: context,
                    initialDate: initialDate,
                    firstDate: firstDate,
                    lastDate: DateTime(2100),
                  );

                  if (dateSelected == null) return;
                  if (!context.mounted) {
                    dueDate = dateSelected.toIso8601String();
                    dueDateController.text = dueDate;
                    return;
                  }

                  TimeOfDay initialTime;
                  try {
                    initialTime = TimeOfDay.fromDateTime(initialDate!);
                  } catch (e) {
                    initialTime = TimeOfDay.fromDateTime(dateSelected);
                  }
                  final TimeOfDay? timeSelected = await showTimePicker(
                    context: context,
                    initialTime: initialTime,
                  );

                  dateSelected = DateTime(dateSelected.year, dateSelected.month,
                      dateSelected.day, timeSelected!.hour, timeSelected.minute);

                  dueDate = dateSelected.toIso8601String();
                  dueDateController.text = dueDate;
                  return;
                },
                child: const Text('Edit Date'),
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        DialogCancelButton(ctx: context),
        TextButton(
            onPressed: taskNameController.value.text.isEmpty
                ? null
                : () {
                    String newTaskDesc = taskNameController.value.text;
                    String newTaskDue = dueDateController.value.text;
                    ref
                        .read(taskViewNotifierProvider.notifier)
                        .updateTask(task: task!, description: newTaskDesc, due: newTaskDue);
                    Navigator.pop(context);
                    SnackbarServices.pushSnackbar(context, 'Task Edited Successfully');
                  },
            child: const Text('EDIT')),
      ],
    );
  }
}
