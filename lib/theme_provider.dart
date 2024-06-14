import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = ThemeData.light();

  ThemeData get currentTheme => _themeData;

  ThemeData getTheme() {
    return _themeData;
  }

  void setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }
}
