import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypage/deletemember_passwordcheck/deletemember_passwordcheck.dart';

class DeleteMember extends StatelessWidget {
  DeleteMember({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10), // 상단 여백을 최소화
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
                child: Text(
                  '회원 탈퇴',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 300),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
                child: Text(
                  '회원을 탈퇴하면 지금까지 작성한 모든 컨텐츠가 사라집니다.\n많은 소중한 추억을 없애도 좋습니까?',
                  style: TextStyle(fontSize: 18),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>PasswordCheck()),
                    );
                  },
                  child: Text('없애기'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue, // 버튼 텍스트 색 변경
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('돌아가기'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
