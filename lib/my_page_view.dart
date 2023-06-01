import 'package:flutter/material.dart';
import 'package:login/routes/info.dart';
import 'package:login/routes/timer.dart';
import 'package:login/MainPage.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({super.key});

  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Style",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: <Widget>[
          Container(
            //page 1, 메인 페이지
            child: const MainPage(),
          ),
          Container(
            //page 2, 절전 페이지
            child: const PowerSavingModePage(),
          ),
          Container(
              //page 3, 정보 페이지
              child: const Info()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (int index) {
          setState(() {
            _currentPage = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.developer_mode_rounded),
            label: "모드",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.battery_alert),
            label: "절전",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: "정보",
          ),
        ],
      ),
    );
  }
}
