import 'package:flutter/material.dart';
import 'bluetooth_helper.dart';
import 'chat_screen.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceListScreen extends StatelessWidget {
  final BluetoothHelper bluetoothHelper;

  DeviceListScreen({required this.bluetoothHelper});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Device'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<BluetoothDevice>>(
        future: bluetoothHelper.getPairedDevices(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No devices found'));
          } else {
            return ListView(
              children: snapshot.data!.map((device) {
                return ListTile(
                  title: Text(
                      device.name.isNotEmpty ? device.name : 'Unknown Device'),
                  subtitle: Text(device.id.toString()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          bluetoothHelper: bluetoothHelper,
                          device: device,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
