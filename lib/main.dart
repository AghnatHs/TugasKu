import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/constants.dart';
import 'package:todo_app/database/app_setting_database_provider.dart';
import 'package:todo_app/database/task_database_provider.dart';
import 'package:todo_app/notifier/app_setting_view_notifier.dart';
import 'package:todo_app/notifier/app_about_notifier.dart';
import 'package:todo_app/presentation/screens/main_screen.dart';

// TODO: CREATE REALM FLEXIBLE SYNC
 
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  final SharedPreferences sharedfPreferences = await SharedPreferences.getInstance();

  await dotenv.load(fileName: '.env');
  
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/monsterrat_OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/yantramanav_OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  return runApp(
    ProviderScope(
      overrides: [
        realmAppIdProvider.overrideWithValue(dotenv.env[DOTENV.REALM_APP_ID]!),
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
    // TODO: Set this to true at development
    GoogleFonts.config.allowRuntimeFetching = false;

    return MaterialApp(
      title: 'TugasKu',
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
