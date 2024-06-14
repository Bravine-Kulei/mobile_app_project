import 'package:flutter/material.dart';
import 'device_list_screen.dart';
import 'bluetooth_helper.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            BluetoothHelper bluetoothHelper = BluetoothHelper();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    DeviceListScreen(bluetoothHelper: bluetoothHelper),
              ),
            );
          },
          child: Text('Start Chat'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
