import 'package:flutter/material.dart';
import 'package:login/design_set/rgb_picker.dart';

enum AnimationType {
  upAndDown,
  leftAndRight,
  fade,
  falling,
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Color _currentColor = Colors.white;
  Color? selectedColor;
  AnimationType? _selectedAnimationType;

  void save() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('저장이 되었습니다!'),
          content: const Text('설정이 저장 되었습니다.'),
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

  void _changeColor(Color color) {
    setState(() {
      _currentColor = color;
    });
  }

  void _storeColor() {
    setState(() {
      selectedColor = _currentColor;
    });
  }

  void _selectAnimationType(AnimationType type) {
    setState(() {
      _selectedAnimationType = type;
    });
  }

  void _confirmSelection() {
    if (_selectedAnimationType != null) {
      setState(() {
        selectedAnimationText =
            '설정 애니메이션: ${_selectedAnimationType.toString().split('.').last}';
      });
      save();
    }
  }

  String selectedAnimationText = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          // Wrap the Column with SingleChildScrollView
          child: Column(
            children: [
              ExpansionTile(
                leading: const Icon(Icons.palette_outlined),
                title: const Text('색상'),
                children: [
                  RGBColorPicker(
                    pickerColor: _currentColor,
                    onColorChanged: (color) => _changeColor(color),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _storeColor();
                    },
                    child: const Text('확인'),
                  ),
                  Text(
                    '적용된 색상: ${selectedColor ?? 'None'}',
                    style: TextStyle(
                      color: selectedColor ?? Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              ListTile(
                leading: const Icon(Icons.mode_edit_outline),
                title: const Text('모드'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ModeSelect(),
                    ),
                  );
                },
              ),
              ExpansionTile(
                leading: const Icon(Icons.animation_outlined),
                title: const Text('효과'),
                children: [
                  ...AnimationType.values.map((type) {
                    final isSelected = type == _selectedAnimationType;
                    return ListTile(
                      title: Text(type.toString().split('.').last),
                      onTap: () {
                        _selectAnimationType(type);
                      },
                      tileColor:
                          isSelected ? Colors.grey.withOpacity(0.3) : null,
                    );
                  }).toList(),
                  ElevatedButton(
                    onPressed: _confirmSelection,
                    child: const Text('적용'),
                  ),
                  Text(selectedAnimationText,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ModeSelect extends StatelessWidget {
  const ModeSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('모드'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 100,
            child: ElevatedButton(
              onPressed: () {
                // Button action
              },
              child: const Text(
                '무드등 모드 (안정)',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 100,
            child: ElevatedButton(
              onPressed: () {
                // Button action
              },
              child: const Text(
                '즐거움',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 100,
            child: ElevatedButton(
              onPressed: () {
                // Button action
              },
              child: const Text(
                '파티',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 100,
            child: ElevatedButton(
              onPressed: () {
                // Button action
              },
              child: const Text(
                '집중',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 100,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TestPage(),
                  ),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '새 테마 추가하기',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.add_circle_rounded),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Page'),
      ),
      body: const Center(
        child: Text('8*32 pixel'),
      ),
    );
  }
}
