import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/database/app_setting_database.dart';
import 'package:todo_app/database/app_setting_database_provider.dart';
import 'package:todo_app/model/app_setting_model.dart';

class AppSettingServices {
  static Color getColorFromKey(String seedColorKey) =>
      AppSettingDatabase.getColorFromKey(seedColorKey);

  static void setSeedColor(Ref ref, String seedColor) {
    ref.watch(appSettingDatabaseProvider).setSeedColor(seedColor);
  }

  static void toogleBrightness(Ref ref) {
    ref.watch(appSettingDatabaseProvider).toogleBrightness();
  }

  static AppSetting getAppSetting(Ref ref) {
    return ref.watch(appSettingDatabaseProvider).getAppSetting();
  }

  static bool isDark(Ref ref) {
    return ref.watch(appSettingDatabaseProvider).isDark;
  }
}
