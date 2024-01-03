//Creating dialog, push snackbar, push navigator etc
import 'package:flutter/material.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/presentation/widgets/info_widgets/help_dialog.dart';
import 'package:todo_app/presentation/widgets/info_widgets/edit_task_dialog.dart';
import 'package:todo_app/presentation/widgets/setting_widgets/choose_seed_color_dialog.dart';
import 'package:todo_app/presentation/widgets/shared/create_task_dialog.dart';

class DialogServices {
  static pushTaskDialog(BuildContext context) {
    showDialog(
      barrierColor: Colors.black54,
      context: context,
      builder: (BuildContext context) => const CreateTaskDialog(),
    );
  }

  static pushHelpDialog(BuildContext context) {
    showDialog(
      barrierColor: Colors.black54,
      context: context,
      builder: (BuildContext context) => const HelpDialog(),
    );
  }

  static pushEditTaskDialog(BuildContext context, Task task) {
    showDialog(
      barrierColor: Colors.black54,
      context: context,
      builder: (BuildContext context) => EditTaskDialog(
        task: task,
      ),
    );
  }

  static pushChooseSeedColorDialog(BuildContext context) {
    showDialog(
      barrierColor: Colors.black54,
      context: context,
      builder: (BuildContext context) => const ChooseSeedColorDialog(),
    );
  }
}
