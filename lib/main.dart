import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/database/app_setting_database_provider.dart';
import 'package:todo_app/notifier/app_setting_view_notifier.dart';
import 'package:todo_app/notifier/app_about_notifier.dart';
import 'package:todo_app/presentation/screens/main_screen.dart';

// TODO : CREATE REALM FLEXIBLE SYNC
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  final SharedPreferences sharedfPreferences = await SharedPreferences.getInstance();

  return runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedfPreferences),
        appVersionNotifierProvider.overrideWithValue(packageInfo.version),
      ],
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends ConsumerWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'ToDo List App',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ref.watch(appSettingViewProvider).seedColor,
          brightness: ref.watch(appSettingViewProvider).brightness,
        ),
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
