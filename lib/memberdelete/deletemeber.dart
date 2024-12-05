import 'package:flutter/material.dart';
import 'package:mypage/deletemember_passwordcheck/deletemember_passwordcheck.dart';
import '../constants.dart'; // constants.dart 파일 임포트
import '../routes.dart';
import '../tappage/tapPage.dart'; // routes.dart 파일 임포트

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
          mainAxisAlignment: MainAxisAlignment.center,
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
                width: double.infinity,
                child: const Text(
                  '회원을 탈퇴하면 지금까지 작성한 \n모든 컨텐츠가 사라집니다.\n많은 소중한 추억들을 \n삭제해도 괜찮습니까?',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // 버튼들
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PasswordCheck()),
                    );
                  },
                  child: const Text('없애기'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppConstants.buttonTextColor,
                    backgroundColor: AppConstants.primaryColor,
                  ),
                  onPressed: () {
                    // TapPage로 이동하면서 AccountPage 선택
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TapPage(initialIndex: 2), // AccountPage로 가는 인덱스 설정
                      ),
                    );
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
