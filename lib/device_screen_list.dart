import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'chat_screen.dart';
import 'bluetooth_helper.dart';

class DeviceListScreen extends StatefulWidget {
  const DeviceListScreen({Key? key}) : super(key: key);

  @override
  _DeviceListScreenState createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  FlutterBlue flutterBlue = FlutterBlue.instance;

  @override
  void initState() {
    super.initState();
    flutterBlue.startScan(timeout: const Duration(seconds: 4));
  }

  @override
  void dispose() {
    flutterBlue.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Device List')),
      body: StreamBuilder<List<ScanResult>>(
        stream: flutterBlue.scanResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No devices found'));
          } else {
            return ListView(
              children: snapshot.data!.map((result) {
                return ListTile(
                  title: Text(result.device.name.isNotEmpty
                      ? result.device.name
                      : 'Unknown Device'),
                  subtitle: Text(result.device.id.toString()),
                  onTap: () async {
                    BluetoothHelper bluetoothHelper =
                        BluetoothHelper(device: result.device);
                    await bluetoothHelper.connectToDevice();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                            bluetoothHelper: bluetoothHelper,
                            device: result.device),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () {
          flutterBlue.startScan(timeout: const Duration(seconds: 4));
        },
      ),
    );
  }
}
