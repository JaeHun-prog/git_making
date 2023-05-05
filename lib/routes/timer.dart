import 'package:flutter/material.dart';

class PowerSavingModePage extends StatefulWidget {
  const PowerSavingModePage({super.key});

  @override
  _PowerSavingModePageState createState() => _PowerSavingModePageState();
}

class _PowerSavingModePageState extends State<PowerSavingModePage> {
  int _selectedHour = 0;
  int _selectedMinute = 0;
  int _selectedSecond = 0;

  void _saveSettings() {
    // Perform save operation here
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('저장이 되었습니다!'),
          content: const Text('Power-saving mode settings have been saved.'),
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
            const Text(
              'Set Power-saving Mode Time',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text('Hour'),
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
                          child: Text('$index'),
                        );
                      }),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text('Minute'),
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
                          child: Text('$index'),
                        );
                      }),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text('Second'),
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
                          child: Text('$index'),
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20.0),
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
