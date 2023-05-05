import 'package:flutter/material.dart';
import 'package:login/routes/info.dart';
import 'package:login/routes/timer.dart';

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
        title: const Text("PageView Example"),
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
            color: Colors.red,
            child: const Center(
              child: Text(
                "Page 1",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
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
            icon: Icon(Icons.looks_one),
            label: "Page 1",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_two),
            label: "Page 2",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_3),
            label: "Page 3",
          ),
        ],
      ),
    );
  }
}
