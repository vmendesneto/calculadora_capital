import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme_color.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeNotifier extends StateNotifier<ThemeData> {
  final ThemeData _themeData;

  ThemeNotifier(this._themeData) : super(_themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    state = themeData;
  }

  void onThemeChanged(int value, ThemeNotifier themeNotifier) async {
    themeNotifier.setTheme(themes[value]);
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt('theme', value);
  }
}


