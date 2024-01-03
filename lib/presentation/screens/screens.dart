import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:todo_app/core/fonts.dart';
import 'package:todo_app/model/app_setting_model.dart';
import 'package:todo_app/notifier/app_setting_view_notifier.dart';
import 'package:todo_app/notifier/task_view_notifier.dart';
import 'package:todo_app/presentation/widgets/shared/tasks_due_section.dart';
import 'package:todo_app/presentation/widgets/shared/no_task_placeholder.dart';
import 'package:todo_app/services/ui/dialog_services.dart';
import 'package:settings_ui/settings_ui.dart';

class InfoScreen extends ConsumerStatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<InfoScreen> createState() => InfoScreenState();
}

class InfoScreenState extends ConsumerState<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    int allTasksLength = ref.watch(taskViewNotifierProvider).length;
    return allTasksLength == 0
        ? const NoTaskPlaceHolder()
        : SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //TODAY DATE
                  Text(DateFormat('EE, d MMMM').format(DateTime.now()),
                      style: GFont.monsterratTitle.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Badge(
                          label: Text(allTasksLength.toString()),
                          child: Text('My Tasks ',
                              style: GFont.monsterratTitle
                                  .copyWith(fontWeight: FontWeight.w700, fontSize: 17)),
                        ),
                      ),
                      IconButton(
                          onPressed: () => DialogServices.pushHelpDialog(context),
                          icon: const Icon(Icons.info))
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  //Later Tasks
                  Expanded(
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            TaskDueSection(
                                dueTitle: 'Late',
                                tasks:
                                    ref.watch(taskViewNotifierProvider.notifier).lateTasks()),
                            TaskDueSection(
                                dueTitle: 'Today',
                                tasks:
                                    ref.watch(taskViewNotifierProvider.notifier).todayTasks()),
                            TaskDueSection(
                                dueTitle: 'Tomorrow',
                                tasks: ref
                                    .watch(taskViewNotifierProvider.notifier)
                                    .tomorrowTasks()),
                            TaskDueSection(
                                dueTitle: 'This Week',
                                tasks: ref
                                    .watch(taskViewNotifierProvider.notifier)
                                    .thisWeekTasks()),
                            TaskDueSection(
                                dueTitle: 'Next Week',
                                tasks: ref
                                    .watch(taskViewNotifierProvider.notifier)
                                    .nextWeekTasks()),
                            TaskDueSection(
                                dueTitle: 'This Month',
                                tasks: ref
                                    .watch(taskViewNotifierProvider.notifier)
                                    .thisMonthTasks()),
                            TaskDueSection(
                                dueTitle: 'Later',
                                tasks:
                                    ref.watch(taskViewNotifierProvider.notifier).laterTasks()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int allTasksLength = ref.watch(taskViewNotifierProvider).length;
    int lateTasksLength = ref.watch(lateTaskCounterProvider);
    int todayTasksLength = ref.watch(todayTaskCounterProvider);
    int tomorrowTasksLength = ref.watch(tomorrowTaskCounterProvider);
    double completedTasksPercent = ref.watch(completedTaskPercentageProvider);
    int completedTasksCount = ref.watch(completedTaskCounterProvider);
    int lateTaskUncompletedCount = ref.watch(lateTaskUncompletedCounterProvider);

    return allTasksLength == 0
        ? const NoTaskPlaceHolder()
        : SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateFormat('EE, d MMMM').format(DateTime.now()),
                      style: GFont.monsterratTitle.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(
                    'You have\n$todayTasksLength task for today !',
                    style: GFont.monsterratTitle
                        .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: const Text('Task Completed (Total)'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '$completedTasksCount / $allTasksLength task done\n$lateTaskUncompletedCount tasks are late !'),
                          const SizedBox(
                            height: 10,
                          ),
                          allTasksLength == 0
                              ? Container()
                              : LinearPercentIndicator(
                                  padding: EdgeInsets.zero,
                                  percent: completedTasksPercent / 100,
                                  lineHeight: 20,
                                  progressColor: Theme.of(context).colorScheme.primary,
                                  backgroundColor: Theme.of(context).disabledColor,
                                  center: Text(
                                      '${completedTasksPercent.ceil().toStringAsFixed(0)} %'),
                                )
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  lateTasksLength == 0 && todayTasksLength == 0 && tomorrowTasksLength == 0
                      ? Container()
                      : Text(
                          'Deadline coming !',
                          style: GFont.monsterratTitle2.copyWith(fontWeight: FontWeight.bold),
                        ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            TaskDueSection(
                                dueTitle: 'Late',
                                tasks:
                                    ref.watch(taskViewNotifierProvider.notifier).lateTasks()),
                            TaskDueSection(
                                dueTitle: 'Today',
                                tasks:
                                    ref.watch(taskViewNotifierProvider.notifier).todayTasks()),
                            TaskDueSection(
                                dueTitle: 'Tomorrow',
                                tasks: ref
                                    .watch(taskViewNotifierProvider.notifier)
                                    .tomorrowTasks()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppSetting appSetting = ref.watch(appSettingViewProvider);
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Settings',
        style: GFont.monsterratTitle.copyWith(fontWeight: FontWeight.bold),
      )),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Theme'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.format_paint),
                title: const Text('Color'),
                value: Text(appSetting.color),
                onPressed: (BuildContext context) {
                  DialogServices.pushChooseSeedColorDialog(context);
                },
              ),
              SettingsTile.switchTile(
                onToggle: (value) {
                  ref.watch(appSettingViewProvider.notifier).toogleBrightness();
                  value = !value;
                },
                initialValue: appSetting.isDark,
                leading: appSetting.isDark
                    ? const Icon(Icons.wb_sunny)
                    : const Icon(Icons.wb_sunny_outlined),
                title: const Text('Dark Mode'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
