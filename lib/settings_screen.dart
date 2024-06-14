import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key})
      : super(key: key); // Remove onThemeChanged parameter

  @override
  Widget build(BuildContext context) {
    // Build settings UI
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Center(
        child: Text('Settings Page'),
      ),
    );
  }
}
