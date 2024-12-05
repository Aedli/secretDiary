import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypage/deletemember_passwordcheck/deletemember_passwordcheck.dart';
import '../constants.dart'; // constants.dart 파일 임포트

class DeleteMember extends StatelessWidget {
  const DeleteMember({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원 탈퇴'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 회원 탈퇴 제목
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: AppConstants.backgroundColor,
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  border: Border.all(color: Colors.black),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Text(
                  '회원 탈퇴',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 탈퇴 경고 메시지
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: AppConstants.backgroundColor,
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  border: Border.all(color: Colors.black),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                width: double.infinity, // 최대 너비 설정
                child: const Text(
                  '회원을 탈퇴하면 지금까지 작성한 \n모든 컨텐츠가 사라집니다.\n많은 소중한 추억들을 \n삭제해도 괜찮습니까?',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.left, // 왼쪽 정렬
                ),
              ),
            ),
            const SizedBox(height: 40),

            // 버튼들
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // 버튼을 중앙 정렬
              children: [
                OutlinedButton( // OutlinedButton 사용
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.black), // 테두리 색상 설정
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PasswordCheck()),
                    );
                  },
                  child: const Text('없애기'), // 버튼 텍스트
                ),
                const SizedBox(width: 20), // 버튼 간격
                ElevatedButton( // 돌아가기 버튼은 그대로 유지
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppConstants.buttonTextColor,
                    backgroundColor: AppConstants.primaryColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('돌아가기'),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
