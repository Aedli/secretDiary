import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypage/memberdelete/deletemeber.dart';

import '../secretnumchange/secretnum_change.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('  마이페이지'),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 8,
              ),
              Icon(
                Icons.send,
              ),
              SizedBox(
                width: 8,
              ),
              Text('이름: OOO'),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 8,
              ),
              Icon(
                Icons.favorite_border,
              ),
              SizedBox(
                width: 8,
              ),
              Text('아이디 : OOOO'),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            color: Colors.grey, // 선 색상
            thickness: 1, // 선 두께
            indent: 16, // 왼쪽 여백
            endIndent: 16, // 오른쪽 여백
          ),
          Text('   계정정보'),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecretNumChange()),
              );
            },
            child: Row(
              children: [
                SizedBox(width: 8),
                Icon(Icons.settings),
                SizedBox(width: 8),
                Text('비밀번호 변경'),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeleteMember()),
              );
            },
            child: Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.highlight_off,
                ),
                SizedBox(
                  width: 8,
                ),
                Text('회원탈퇴'),
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Container(
      //         width: 40.0, // 원의 크기
      //         height: 40.0,
      //         decoration: BoxDecoration(
      //           color: Colors.blue, // 원 배경 색상
      //           shape: BoxShape.circle, // 원 모양
      //         ),
      //         child: Icon(
      //           Icons.menu,
      //           color: Colors.white, // 아이콘 색상
      //           size: 24.0, // 아이콘 크기
      //         ),
      //       ),
      //       label: '다이어리', //last parameter comma
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.edit),
      //       label: '글쓰기', //last parameter comma
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person_2_outlined),
      //       label: '마이페이지', //last parameter comma
      //     ),
      //   ], //reformat code : ctrl+alt+l
      // ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
