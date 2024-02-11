import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/model/app_setting_model.dart';
import 'package:todo_app/services/app_setting/app_setting_services.dart';

final appSettingViewProvider = StateNotifierProvider<AppSettingViewNotifier, AppSetting>(
    (ref) => AppSettingViewNotifier(ref));

class AppSettingViewNotifier extends StateNotifier<AppSetting> {
  final Ref ref;
  AppSettingViewNotifier(this.ref) : super(AppSettingServices.getAppSetting(ref));

  void setSeedColor(String seedColor) {
    AppSettingServices.setSeedColor(ref, seedColor);
    state = AppSettingServices.getAppSetting(ref);
  }

  void toogleBrightness() {
    AppSettingServices.toogleBrightness(ref);
    state = AppSettingServices.getAppSetting(ref);
  }

  void setTaskFontSize(int fontSize) {
    AppSettingServices.setTaskFontSize(ref, fontSize);
    state = AppSettingServices.getAppSetting(ref);
  }

  bool isDark() {
    return AppSettingServices.isDark(ref);
  }
}
