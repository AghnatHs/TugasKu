import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/constants.dart';
import 'package:todo_app/model/app_setting_model.dart';

class AppSettingDatabase {
  final SharedPreferences _prefs;
  late String seedColorIdentifier;
  late bool isDark;
  late int taskFontSize;
  AppSettingDatabase(this._prefs) {
    seedColorIdentifier = getSeedColor();
    isDark = getBrightness();
  }

  void setSeedColor(String seedColor) {
    _prefs.setString(SETTINGS_KEY.SEED_COLOR_KEY, seedColor);
    seedColorIdentifier = getSeedColor();
  }

  String getSeedColor() =>
      _prefs.getString(SETTINGS_KEY.SEED_COLOR_KEY) ?? SETTINGS_KEY.SEED_COLOR_GREEN;

  void toogleBrightness() {
    _prefs.setBool(SETTINGS_KEY.BRIGHTNESS_KEY, !isDark);
    isDark = getBrightness();
  }

  bool getBrightness() => _prefs.getBool(SETTINGS_KEY.BRIGHTNESS_KEY) ?? true;

  void setTaskFontSize(int fontSize) {
    _prefs.setInt(SETTINGS_KEY.TASK_FONT_SIZE_KEY, fontSize);
  }

  int getTaskFontSize() =>
      _prefs.getInt(SETTINGS_KEY.TASK_FONT_SIZE_KEY) ?? SETTINGS_KEY.TASK_FONT_SIZE_DEFAULT;

  static Color getColorFromKey(String seedColorKey) {
    Color seedColor;
    switch (seedColorKey) {
      case SETTINGS_KEY.SEED_COLOR_AMBER:
        seedColor = Colors.amber;
      case SETTINGS_KEY.SEED_COLOR_BLUE:
        seedColor = Colors.blue;
      case SETTINGS_KEY.SEED_COLOR_BLUE_GREY:
        seedColor = Colors.blueGrey;
      case SETTINGS_KEY.SEED_COLOR_BROWN:
        seedColor = Colors.brown;
      case SETTINGS_KEY.SEED_COLOR_CYAN:
        seedColor = Colors.cyan;
      case SETTINGS_KEY.SEED_COLOR_GREEN:
        seedColor = Colors.green;
      case SETTINGS_KEY.SEED_COLOR_GREY:
        seedColor = Colors.grey;
      case SETTINGS_KEY.SEED_COLOR_INDIGO:
        seedColor = Colors.indigo;
      case SETTINGS_KEY.SEED_COLOR_LIME:
        seedColor = Colors.lime;
      case SETTINGS_KEY.SEED_COLOR_ORANGE:
        seedColor = Colors.orange;
      case SETTINGS_KEY.SEED_COLOR_PINK:
        seedColor = Colors.pink;
      case SETTINGS_KEY.SEED_COLOR_PURPLE:
        seedColor = Colors.purple;
      case SETTINGS_KEY.SEED_COLOR_RED:
        seedColor = Colors.red;
      case SETTINGS_KEY.SEED_COLOR_TEAL:
        seedColor = Colors.teal;
      case SETTINGS_KEY.SEED_COLOR_YELLOW:
        seedColor = Colors.yellow;
      default:
        seedColor = Colors.green;
    }

    return seedColor;
  }

  AppSetting getAppSetting() {
    Color seedColor = getColorFromKey(seedColorIdentifier);
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;
    int taskFontSize = getTaskFontSize();

    return AppSetting(
      seedColor,
      brightness,
      seedColorIdentifier,
      isDark,
      taskFontSize,
    );
  }
}
