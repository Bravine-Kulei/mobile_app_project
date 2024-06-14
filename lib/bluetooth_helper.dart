import 'dart:convert';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothHelper {
  final BluetoothDevice device;
  BluetoothCharacteristic? _characteristic;

  BluetoothHelper({required this.device});

  Future<void> connectToDevice() async {
    await device.connect();
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.properties.write) {
          _characteristic = characteristic;
          break;
        }
      }
      if (_characteristic != null) break;
    }
  }

  Future<void> disconnect() async {
    await device.disconnect();
  }

  Future<void> sendMessage(String message) async {
    if (_characteristic != null) {
      List<int> bytes = utf8.encode(message);
      await _characteristic!.write(bytes);
    } else {
      throw Exception("No writable characteristic found");
    }
  }

  Future<void> startScanning() async {
    FlutterBlue.instance.startScan(timeout: Duration(seconds: 4));
  }

  Stream<List<ScanResult>> get scanResults => FlutterBlue.instance.scanResults;

  Future<void> stopScanning() async {
    FlutterBlue.instance.stopScan();
  }
}
