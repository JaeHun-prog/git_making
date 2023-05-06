import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Info extends StatelessWidget {
  const Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: InfoContent(),
      ),
    );
  }
}

class InfoContent extends StatefulWidget {
  const InfoContent({Key? key}) : super(key: key);

  @override
  _InfoContentState createState() => _InfoContentState();
}

class _InfoContentState extends State<InfoContent> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> _infoData;

  @override
  void initState() {
    super.initState();
    _infoData = _fetchInfoData();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _fetchInfoData() async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('info');
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await usersCollection.doc('users').get()
            as DocumentSnapshot<Map<String, dynamic>>;
    return snapshot;
  }

  Widget _buildUsageMethod(List<dynamic>? usageMethod) {
    if (usageMethod == null || usageMethod.isEmpty) {
      return const Text('No usage method found');
    }
    final String joinedUsageMethod = usageMethod.join('\n');
    return Text(
      joinedUsageMethod,
      style: const TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
    );
  }

  Widget _buildFAQ(List<dynamic>? faq) {
    if (faq == null || faq.isEmpty) {
      return const Text('No frequently asked questions found');
    }
    final String joinedFAQ = faq.join('\n');
    return Text(
      joinedFAQ,
      style: const TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: _infoData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data'));
        }
        final Map<String, dynamic>? data = snapshot.data?.data();
        if (data == null) {
          return const Center(child: Text('No data found'));
        }
        return Column(
          children: [
            ExpansionTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Version Information'),
              children: [
                Text(
                  data['versionInfo']?.toString() ?? '',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.featured_play_list_outlined),
              title: const Text('Main features and usage'),
              children: [
                _buildUsageMethod(data['usageGuide']),
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.question_mark_outlined),
              title: const Text('Frequently Asked Questions'),
              children: [
                _buildFAQ(data['frequentlyAskedQuestions']),
              ],
            ),
          ],
        );
      },
    );
  }
}




/*
class _InfoContentState extends State<InfoContent> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> _infoData;

  @override
  void initState() {
    super.initState();
    _infoData = _fetchInfoData();
  }

  //firestore의 info 컬렉션-users문서-data get
  Future<DocumentSnapshot<Map<String, dynamic>>> _fetchInfoData() async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('info');
    final DocumentSnapshot<Object?> snapshot =
        await usersCollection.doc('users').get();
    return snapshot as DocumentSnapshot<Map<String, dynamic>>;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: _infoData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data'));
        }
        final Map<String, dynamic>? data = snapshot.data?.data();
        if (data == null) {
          return const Center(child: Text('No data found'));
        }
        return Column(
          children: [
            ExpansionTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Version Information'),
              children: [
                Text(
                  //버전정보 필드 data get
                  data['versionInfo'] ?? '',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.featured_play_list_outlined),
              title: const Text('Main features and usage'),
              children: [
                Text(
                  //사용방법 필드 data get
                  data['usageGuide'] ?? '',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.question_mark_outlined),
              title: const Text('Frequently Asked Questions'),
              children: [
                Text(
                  //자주묻는질문 필드 data get
                  data['frequentlyAskedQuestions'] ?? '',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}*/
