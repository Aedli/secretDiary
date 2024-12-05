import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypage/screens/login_screen.dart';
import '../constants.dart'; // constants.dart 파일 임포트

class DeleteFinish extends StatelessWidget {
  DeleteFinish({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100), // 상단 여백을 추가하여 회원 탈퇴 메시지를 아래로 이동

            Padding(
              padding: const EdgeInsets.only(top: 10), // 상단 여백을 최소화
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
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
            const SizedBox(height: 150), // 여백 조정

            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                  color: AppConstants.backgroundColor, // 배경색 설정
                ),
                child: const Text(
                  '탈퇴 처리되었습니다.\n저희 앱을 사랑해주셔서 감사합니다',
                  style: TextStyle(fontSize: 18),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center, // 텍스트 중앙 정렬
                ),
              ),
            ),
            const SizedBox(height: 40),

            // 확인 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppConstants.primaryColor, // 버튼 배경색 설정
                  ),
                  onPressed: () {
                    // 확인 버튼 클릭 시 LoginScreen으로 이동
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()), // LoginScreen 페이지로 이동
                    );
                  },
                  child: const Text('확인'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
