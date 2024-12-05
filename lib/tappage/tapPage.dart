import 'package:flutter/material.dart';
import 'package:mypage/griddiarypage/grid_diary_page.dart';
import 'package:mypage/accountpage/account_page.dart';
import 'package:mypage/diarywritepage/diary_write_page.dart';
class TapPage extends StatefulWidget {
  const TapPage({super.key});

  //const TapPage({key? key}) : super(key: key);

  @override
  State<TapPage> createState() => _TapPageState();
}

class _TapPageState extends State<TapPage> {
  int _currentIndex = 0;

  final _pages = const [
    GridDiary(),
    DiaryWritePage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: '다이어리',//last parameter comma
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: '글쓰기',//last parameter comma
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '마이페이지',//last parameter comma
          ),
        ],//reformat code : ctrl+alt+l
      ),
    );
  }
}
