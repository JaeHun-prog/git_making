import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class PowerSavingModePage extends StatefulWidget {
  const PowerSavingModePage({Key? key}) : super(key: key);

  @override
  _PowerSavingModePageState createState() => _PowerSavingModePageState();
}

class _PowerSavingModePageState extends State<PowerSavingModePage> {
  final int _selectedHour = 0;
  final int _selectedMinute = 0;
  final int _selectedSecond = 0;
  late BluetoothDevice _device;
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _startBluetoothConnection();
  }

  void _startBluetoothConnection() async {
    FlutterBlue flutterBlue = FlutterBlue.instance;
    List<ScanResult> scanResults =
        await flutterBlue.scan(timeout: const Duration(seconds: 4)).toList();
    ScanResult deviceResult = scanResults.firstWhere(
      (result) => result.device.name == 'ESP32_plz',
      orElse: () => throw Exception('ESP32 device not found'),
    );
    _device = deviceResult.device;

    await _device.connect();
    setState(() {
      _isConnected = true;
    });
  }

  void _saveSettings() async {
    if (!_isConnected) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Bluetooth Connection Error'),
            content:
                const Text('Bluetooth connection failed. Please try again.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    String configuration = '$_selectedHour:$_selectedMinute:$_selectedSecond';
    List<int> bytes = utf8.encode(configuration);
    List<BluetoothService> services = await _device.discoverServices();
    BluetoothCharacteristic? characteristic;

    for (BluetoothService service in services) {
      if (service.uuid.toString() == 'c5056b11-a797-470c-9259-9c2980763aeb') {
        for (BluetoothCharacteristic c in service.characteristics) {
          if (c.uuid.toString() == 'beb5483e-36e1-4688-b7f5-ea07361b26a8') {
            characteristic = c;
            break;
          }
        }
      }
      if (characteristic != null) {
        break;
      }
    }

    if (characteristic == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Cannot find the Bluetooth characteristic.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    await characteristic.write(bytes);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Settings Saved!'),
          content: const Text('Power saving mode settings have been saved.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<int>(
              value: _selectedHour,
              onChanged: null, // Set onChanged to null to disable the dropdown
              items: List.generate(24, (index) {
                return DropdownMenuItem<int>(
                  value: index,
                  child: Text('$index hours'),
                );
              }),
            ),
            DropdownButton<int>(
              value: _selectedMinute,
              onChanged: null, // Set onChanged to null to disable the dropdown
              items: List.generate(60, (index) {
                return DropdownMenuItem<int>(
                  value: index,
                  child: Text('$index minutes'),
                );
              }),
            ),
            DropdownButton<int>(
              value: _selectedSecond,
              onChanged: null, // Set onChanged to null to disable the dropdown
              items: List.generate(60, (index) {
                return DropdownMenuItem<int>(
                  value: index,
                  child: Text('$index seconds'),
                );
              }),
            ),
            ElevatedButton(
              onPressed: _saveSettings,
              child: const Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
