import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/database/app_setting_database.dart';

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

final appSettingDatabaseProvider = Provider<AppSettingDatabase>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return AppSettingDatabase(prefs);
});
