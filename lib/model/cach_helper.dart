import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../constants.dart";

class CachHelper with ChangeNotifier {
  //Themes
  final darkTheme = Constants.kDarkTheme;
  final lightTheme = Constants.kLightTheme;
  SharedPreferences? pref;
  String kIsDark = "isDark";
  String kIsFirstTime = "isFristTime";
  bool? isDark;
  bool? isFirstTime ;
  init() async {
    pref = await SharedPreferences.getInstance();
    notifyListeners();
  }
  loadPref() async {
    await init();
    isDark = pref!.getBool(kIsDark)==null ? false : pref!.getBool(kIsDark)==true?true:false;
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
