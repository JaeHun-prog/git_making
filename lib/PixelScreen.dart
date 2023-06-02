import 'package:login/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PixelScreen extends StatefulWidget {
  const PixelScreen({Key? key}) : super(key: key);

  @override
  PixelScreenState createState() => PixelScreenState();
}

class PixelScreenState extends State<PixelScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Color> _colorlist = [];
  List<bool> _pixelData = [];
  List<Color> genrateColorslist() {
    List<Color> colorslist = [];
    for (int i = 0; i < (32 * 8); i++) {
      colorslist.add(const Color.fromARGB(255, 81, 81, 81));
      _pixelData.add(false);
    }
    return colorslist;
  }

  @override
  void initState() {
    super.initState();
    _colorlist = genrateColorslist();
  }

  Future<void> saveToFirestore() async {
    try {
      CollectionReference pixelCollection = FirebaseFirestore.instance
          .collection('design')
          .doc('test')
          .collection('pixel');

      // Clear previous data
      await pixelCollection.doc('num').set({'num_i': []});

      // Generate pixel data array
      List<int> pixelDataArray = [];
      for (bool pixelValue in _pixelData) {
        int value = pixelValue ? 255 : 0;
        pixelDataArray.add(value);
      }

      // Save pixel data to Firestore
      await pixelCollection.doc('num').set({'num_i': pixelDataArray});

      // Success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data saved to Firestore')),
      );
    } catch (e) {
      // Error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save data to Firestore')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
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
                        setState(() {
                          _pixelData[index] = !_pixelData[index];
                          _colorlist[index] = _pixelData[index]
                              ? Colors.red
                              : const Color.fromARGB(255, 79, 79, 79);
                        });
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: saveToFirestore,
                  child: const Icon(Icons.save),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to MainPage.dart when back button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MainPage()),
                    );
                  },
                  child: const Icon(Icons.arrow_back),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _colorlist = genrateColorslist();
                      _pixelData = List.filled(8 * 32, false);
                    });
                  },
                  child: const Icon(Icons.refresh),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
