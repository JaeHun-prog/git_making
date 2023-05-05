import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            ExpansionTile(
              leading: Icon(Icons.info_outline),
              title: Text('버전 정보'),
              children: [
                //firebase에서 불러온 버전 정보 Text(data) data에 넣기
                Text(
                  "Test1",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            ExpansionTile(
              leading: Icon(Icons.featured_play_list_outlined),
              title: Text('주요기능 및 사용방법'),
              children: [
                //firebase에서 주요기능 및 사용방법 Text(data) data에 넣기
                Text(
                  "Test1",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                )
              ],
            ),
            ExpansionTile(
              leading: Icon(Icons.question_mark_outlined),
              title: Text('자주 묻는 질문'),
              children: [
                //firebase에서자주 묻는 질문 Text(data) data에 넣기
                Text(
                  "Test1",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
