import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/constants.dart';
import 'package:todo_app/core/fonts.dart';
import 'package:todo_app/notifier/app_setting_view_notifier.dart';
import 'package:todo_app/presentation/widgets/shared/dialog_cancel_button.dart';
import 'package:todo_app/services/app_setting/app_setting_services.dart';

class ChooseSeedColorDialog extends ConsumerStatefulWidget {
  const ChooseSeedColorDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<ChooseSeedColorDialog> createState() => ChooseSeedColorDialogState();
}

class ChooseSeedColorDialogState extends ConsumerState<ChooseSeedColorDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Set a color theme [${ref.watch(appSettingViewProvider).color}]'),
      titleTextStyle: GFont.dialogTitle.copyWith(color: Theme.of(context).colorScheme.primary),
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        width: 270,
        height: 300,
        child: Scrollbar(
          thumbVisibility: true,
          child: GridView.count(
            crossAxisSpacing: 2,
            padding: const EdgeInsets.all(25),
            crossAxisCount: 2,
            children: List.generate(
              SETTINGS_KEY.SEED_COLORS.length,
              (index) {
                String seedColorKey = SETTINGS_KEY.SEED_COLORS[index];
                Color color = AppSettingServices.getColorFromKey(seedColorKey);
                return Card(
                  child: InkWell(
                    splashColor: color,
                    onTap: () {
                      ref.read(appSettingViewProvider.notifier).setSeedColor(seedColorKey);
                    },
                    child: Center(
                        child: Text(
                      seedColorKey,
                      style: TextStyle(color: color),
                    )),
                  ),
                );
              },
            ),
          ),
        ),
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
