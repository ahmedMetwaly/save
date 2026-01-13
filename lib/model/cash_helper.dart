import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../core/theme/app_theme.dart";

class CashHelper with ChangeNotifier {
  //Themes
  final darkTheme = AppTheme.darkTheme;
  final lightTheme = AppTheme.lightTheme;
  SharedPreferences? pref;
  String kIsDark = "isDark";
  String kIsFirstTime = "isFirstTime";
  bool? isDark;
  bool? isFirstTime;
  init() async {
    pref = await SharedPreferences.getInstance();
    notifyListeners();
  }

  loadPref() async {
    await init();
    isDark = pref!.getBool(kIsDark) == null
        ? false
        : pref!.getBool(kIsDark) == true
            ? true
            : false;
    isFirstTime = pref!.getBool(kIsFirstTime);
    notifyListeners();
  }

  setPref(String key, bool value) async {
    await init();
    await pref!.setBool(key, value);

    //print("$key is set with val: $value");
    notifyListeners();
  }
}
