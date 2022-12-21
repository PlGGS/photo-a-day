import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeNotifier with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeModeNotifier() {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    await SharedPreferences.getInstance().then((prefs) {
      int themeMode = prefs.getInt('themeMode') ?? 2;

      switch (themeMode) {
        case 0:
          _themeMode = ThemeMode.light;
          break;
        case 1:
          _themeMode = ThemeMode.dark;
          break;
        case 2:
          _themeMode = ThemeMode.system;
          break;
      }
    });

    notifyListeners();
  }

  Future<void> _saveThemeMode() async {
    await SharedPreferences.getInstance().then((prefs) {
      switch (_themeMode) {
        case ThemeMode.light:
          prefs.setInt('themeMode', 0);
          break;
        case ThemeMode.dark:
          prefs.setInt('themeMode', 1);
          break;
        case ThemeMode.system:
          prefs.setInt('themeMode', 2);
          break;
      }
    });
  }

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode themeMode) {
    if (themeMode == _themeMode) return;

    _themeMode = themeMode;
    notifyListeners();
    _saveThemeMode();
  }
}

class RecentPhotoNotifier with ChangeNotifier {
  String _recentPhotoPath = '';

  RecentPhotoNotifier() {
    _loadRecentPhotoPath();
  }

  Future<void> _loadRecentPhotoPath() async {
    await SharedPreferences.getInstance().then((prefs) {
      String recentPhotoPath = prefs.getString('recentPhotoPath') ?? '';

      _recentPhotoPath = recentPhotoPath;
    });

    notifyListeners();
  }

  Future<void> _saveRecentPhotoPath() async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setString('recentPhotoPath', _recentPhotoPath);
    });
  }

  String get justTookPhoto => _recentPhotoPath;

  set recentPhotoPath(String recentPhotoPath) {
    if (recentPhotoPath == _recentPhotoPath) return;

    _recentPhotoPath = recentPhotoPath;
    notifyListeners();
    _saveRecentPhotoPath();
  }
}
