/*import 'package:cloud_firestore/cloud_firestore.dart';

class Design {
  String color;
  List<List<int>> pixels;

  Design({required this.color, required this.pixels});

  Design.fromMap(Map<String, dynamic> map)
      : color = map['color'],
        pixels = List<List<int>>.from(
            map['pixels'].map((list) => List<int>.from(list)));

  Map<String, dynamic> toMap() {
    return {
      'color': color,
      'pixels': pixels.map((list) => List<dynamic>.from(list)).toList(),
    };
  }

  static Design defaultDesign() {
    List<List<int>> pixels = List.generate(8, (_) => List.filled(32, 0));
    return Design(color: '#000000', pixels: pixels);
  }

  static Design fromSnapshot(DocumentSnapshot<Object?> userDoc) {
    Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
  String email = userDoc.email;
  // 필드 이름은 Firestore의 필드 이름과 일치해야 합니다.
  String color = data['color'];
  List<List<bool>> pixels = List.generate(8, (_) => List.filled(32, false));
  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 32; j++) {
      pixels[i][j] = data['pixels'][i][j];
    }
  }
  return Design(email, color, pixels);

  }
}*/
