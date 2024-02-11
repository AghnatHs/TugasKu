import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/constants.dart';
import 'package:todo_app/core/fonts.dart';
import 'package:todo_app/model/app_setting_model.dart';
import 'package:todo_app/notifier/app_setting_view_notifier.dart';
import 'package:todo_app/presentation/widgets/shared/dialog_cancel_button.dart';

class ChooseTaskFontSizeDialog extends ConsumerStatefulWidget {
  const ChooseTaskFontSizeDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<ChooseTaskFontSizeDialog> createState() => ChooseTaskFontSizeDialogState();
}

class ChooseTaskFontSizeDialogState extends ConsumerState<ChooseTaskFontSizeDialog> {
  @override
  Widget build(BuildContext context) {
    AppSetting appSetting = ref.watch(appSettingViewProvider);
    return AlertDialog(
      title: const Text('Set task font size'),
      titleTextStyle: GFont.dialogTitle.copyWith(color: Theme.of(context).colorScheme.primary),
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        width: 220,
        height: 140,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () => ref
                          .read(appSettingViewProvider.notifier)
                          .setTaskFontSize(appSetting.taskFontSize - 1),
                      icon: const Icon(
                        Icons.arrow_left_outlined,
                        size: 70,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      appSetting.taskFontSize.toString(),
                      style: const TextStyle(fontSize: 25),
                    ),
                  ),
                  IconButton(
                      onPressed: () => ref
                          .read(appSettingViewProvider.notifier)
                          .setTaskFontSize(appSetting.taskFontSize + 1),
                      icon: const Icon(
                        Icons.arrow_right_outlined,
                        size: 70,
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: ElevatedButton(
                    onPressed: () => ref
                        .read(appSettingViewProvider.notifier)
                        .setTaskFontSize(SETTINGS_KEY.TASK_FONT_SIZE_DEFAULT),
                    child: const Text('Reset')),
              )
            ],
          ),
        ),
      ),
      actions: [
        DialogCancelButton(
          ctx: context,
          text: 'CLOSE',
        ),
      ],
    );
  }
}
