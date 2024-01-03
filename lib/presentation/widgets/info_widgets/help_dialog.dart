import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/fonts.dart';
import 'package:todo_app/presentation/widgets/shared/dialog_cancel_button.dart';

class HelpDialog extends ConsumerStatefulWidget {
  const HelpDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<HelpDialog> createState() => HelpDialogState();
}

class HelpDialogState extends ConsumerState<HelpDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Help'),
      titleTextStyle: GFont.dialogTitle.copyWith(color: Theme.of(context).colorScheme.primary),
      insetPadding: EdgeInsets.zero,
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('1. Tap to mark done a task'),
          Text('2. Swipe to delete task'),
          Text('3. Hold a task to edit'),
        ],
      ),
      actions: [
        DialogCancelButton(
          ctx: context,
          text: 'OK',
        ),
      ],
    );
  }
}
