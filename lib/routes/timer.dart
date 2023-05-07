import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class PowerSavingModePage extends StatefulWidget {
  const PowerSavingModePage({Key? key}) : super(key: key);

  @override
  _PowerSavingModePageState createState() => _PowerSavingModePageState();
}

class _PowerSavingModePageState extends State<PowerSavingModePage> {
  int _selectedHour = 0;
  int _selectedMinute = 0;
  int _selectedSecond = 0;
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
      (result) => result.device.name == 'esp32-D07EB8',
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
            title: const Text('Bluetooth 연결 오류'),
            content: const Text('Bluetooth 연결이 실패하였습니다. 다시 시도해주세요.'),
            actions: [
              TextButton(
                child: const Text('확인'),
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
      for (BluetoothCharacteristic c in service.characteristics) {
        if (c.uuid.toString() == 'c5056b11-a797-470c-9259-9c2980763aeb') {
          characteristic = c;
          break;
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
            title: const Text('오류'),
            content: const Text('Bluetooth 특성을 찾을 수 없습니다.'),
            actions: [
              TextButton(
                child: const Text('확인'),
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
          title: const Text('저장이 되었습니다!'),
          content: const Text('절전 모드 설정이 저장되었습니다.'),
          actions: [
            TextButton(
              child: const Text('확인'),
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
              onChanged: (value) {
                setState(() {
                  _selectedHour = value!;
                });
              },
              items: List.generate(24, (index) {
                return DropdownMenuItem<int>(
                  value: index,
                  child: Text('$index hours'),
                );
              }),
            ),
            DropdownButton<int>(
              value: _selectedMinute,
              onChanged: (value) {
                setState(() {
                  _selectedMinute = value!;
                });
              },
              items: List.generate(60, (index) {
                return DropdownMenuItem<int>(
                  value: index,
                  child: Text('$index minutes'),
                );
              }),
            ),
            DropdownButton<int>(
              value: _selectedSecond,
              onChanged: (value) {
                setState(() {
                  _selectedSecond = value!;
                });
              },
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
