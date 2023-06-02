import 'package:flutter/material.dart';

class PixelScreen extends StatefulWidget {
  const PixelScreen({Key? key}) : super(key: key);

  @override
  PixelScreenState createState() => PixelScreenState();
}

class PixelScreenState extends State<PixelScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Color> _colorlist = [];
  List<Color> genrateColorslist() {
    List<Color> colorslist = [];
    for (int i = 0; i < (32 * 8); i++) {
      colorslist.add(const Color.fromARGB(255, 81, 81, 81));
    }
    return colorslist;
  }

  @override
  void initState() {
    super.initState();
    _colorlist = genrateColorslist();
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value),
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          /*Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton.icon(
              style: TextButton.styleFrom(padding: const EdgeInsets.all(14)),
              onPressed: () {
                //showSettingsPage();
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              label: const Text(
                'Connected Device', // 연결된 장치 이름이나 상태를 보여줄 수 있는 텍스트
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),*/
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 32 / 7,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 32,
                  ),
                  itemCount: 8 * 32,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        if (_colorlist[index] == Colors.red) {
                          setState(() {
                            _colorlist[index] =
                                const Color.fromARGB(255, 79, 79, 79);
                          });
                          // sendTextToESP("$index+0");
                        } else {
                          setState(() {
                            _colorlist[index] = Colors.red;
                          });
                          // sendTextToESP("$index+1");
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: _colorlist[index],
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // sendTextToESP("clear");
                setState(() {
                  _colorlist = genrateColorslist();
                });
              },
              child: const Icon(Icons.refresh),
            ),
          )
        ],
      ),
    );
  }
}
/*
  void sendText(String value, HomeState state) async {
    state.sendTextToESP(value);
    showInSnackBar('Sending $value');
  }
  void showSettingsPage() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
            create: (_) => SettingState(), child: const SettingsPage()),
        fullscreenDialog: true));
  }
*/
//}
