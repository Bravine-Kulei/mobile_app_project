// settings_screen.dart
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final Function(ThemeData) onThemeChanged;

  const SettingsScreen({Key? key, required this.onThemeChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Light Theme'),
            onTap: () {
              onThemeChanged(ThemeData.light());
            },
          ),
          ListTile(
            title: const Text('Dark Theme'),
            onTap: () {
              onThemeChanged(ThemeData.dark());
            },
          ),
        ],
      ),
    );
  }
}
