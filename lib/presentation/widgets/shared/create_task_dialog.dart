import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/constants.dart';
import 'package:todo_app/core/fonts.dart';
import 'package:todo_app/notifier/task_view_notifier.dart';
import 'package:todo_app/presentation/widgets/shared/dialog_cancel_button.dart';
import 'package:todo_app/services/ui/snackbar_services.dart';

class CreateTaskDialog extends ConsumerStatefulWidget {
  const CreateTaskDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateTaskDialog> createState() => CreateTaskDialogState();
}

class CreateTaskDialogState extends ConsumerState<CreateTaskDialog> {
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
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Create a new task",
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
                  DateTime? dateSelected = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2090),
                  );

                  if (dateSelected == null) return;
                  if (!context.mounted) {
                    dueDate = dateSelected.toIso8601String();
                    dueDateController.text = dueDate;
                    return;
                  }

                  final TimeOfDay? timeSelected = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(dateSelected),
                  );

                  dateSelected = DateTime(dateSelected.year, dateSelected.month,
                      dateSelected.day, timeSelected!.hour, timeSelected.minute);

                  dueDate = dateSelected.toIso8601String();
                  dueDateController.text = dueDate;
                  return;
                },
                child: const Text('Pick Date'),
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
                    String taskDesc = taskNameController.value.text;
                    ref.read(taskViewNotifierProvider.notifier).createTask(
                          description: taskDesc,
                          due: dueDate == 'none' ? NEW_TASK.DEFAULT_NO_DUE_DATE : dueDate,
                          done: false,
                        );
                    Navigator.pop(context);
                    SnackbarServices.pushSnackbar(context, 'Task added successfully');
                  },
            child: const Text('ADD')),
      ],
    );
  }
}
