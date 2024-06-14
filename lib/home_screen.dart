import 'package:flutter/material.dart';
import 'device_screen_list.dart';
import 'settings_screen.dart'; // Import SettingsScreen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SettingsScreen()), // Remove onThemeChanged parameter
              );
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DeviceListScreen()),
            );
          },
          child: Text('Start Chat'),
        ),
      ),
    );
  }
}
