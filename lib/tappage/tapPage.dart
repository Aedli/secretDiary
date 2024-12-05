import 'package:flutter/material.dart';
import 'package:mypage/griddiarypage/grid_diary_page.dart';
import 'package:mypage/accountpage/account_page.dart';
import 'package:mypage/diarywritepage/diary_write_page.dart';

class TapPage extends StatefulWidget {
  final int initialIndex; // 초기 인덱스를 받기 위한 변수

  const TapPage({super.key, this.initialIndex = 0}); // 기본값 0으로 설정

  @override
  State<TapPage> createState() => _TapPageState();
}

class _TapPageState extends State<TapPage> {
  late int _currentIndex;

  final _pages = const [
    GridDiary(),
    DiaryWritePage(),
    AccountPage(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // 초기 인덱스를 설정
  }

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
            label: '다이어리',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: '글쓰기',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '마이페이지',
          ),
        ],
      ),
    );
  }
}
