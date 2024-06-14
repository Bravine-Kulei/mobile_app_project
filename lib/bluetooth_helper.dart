import 'dart:async';
import 'dart:convert';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothHelper {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  StreamController<String> messageController = StreamController<String>();

  Future<List<BluetoothDevice>> getPairedDevices() async {
    // Start scanning
    flutterBlue.startScan(timeout: const Duration(seconds: 4));

    // Listen to scan results
    List<BluetoothDevice> devices = [];
    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        devices.add(r.device);
      }
    });

    // Stop scanning
    await Future.delayed(const Duration(seconds: 4));
    flutterBlue.stopScan();

    // Return devices after scanning
    return devices;
  }

  Future<void> sendMessage(String message, BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    for (var service in services) {
      var characteristics = service.characteristics;
      for (BluetoothCharacteristic c in characteristics) {
        if (c.properties.write) {
          c.write(utf8.encode(message));
        }
      }
    }
  }
}
