import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypage/deletefinish/deletefinish.dart';

class PasswordCheck extends StatefulWidget {
  PasswordCheck({super.key});

  @override
  _PasswordCheckState createState() => _PasswordCheckState();
}

class _PasswordCheckState extends State<PasswordCheck> {
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore 인스턴스 생성

  // 비밀번호 확인 및 계정 삭제 함수
  Future<void> _deleteAccount() async {
    String password = _passwordController.text;
    User? user = _auth.currentUser;

    // 비밀번호 입력이 비어있는지 확인
    if (password.isEmpty) {
      _showErrorDialog('비밀번호를 입력해주세요.');
      return;
    }

    try {
      // 기존 비밀번호로 사용자 재인증
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);

      // Firestore에서 사용자 정보 삭제
      await _firestore.collection('users').doc(user.uid).delete();

      // 계정 삭제
      await user.delete();

      // 계정 삭제 후 안내 페이지로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DeleteFinish(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      // 오류 처리: 비밀번호가 틀린 경우
      if (e.code == 'wrong-password') {
        _showErrorDialog('비밀번호가 틀렸습니다.');
      } else {
        _showErrorDialog('계정 삭제에 실패했습니다. 다시 시도해주세요.');
      }
    }
  }

  // 오류 메시지 Dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('오류'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Dialog 닫기
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 화살표 뒤로가기 버튼 제거
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
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
              SizedBox(height: 20),
              Text('비밀번호 확인'),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: '비밀번호 입력',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue, // 버튼 텍스트 색 변경
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Back 버튼 클릭 시 뒤로 가기
                    },
                    child: Text('돌아가기'),
                  ),
                ],
              ),
              SizedBox(height: 120),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _deleteAccount, // 탈퇴하기 버튼 클릭 시 계정 삭제
                      child: Text(
                        '탈퇴하기',
                        style: TextStyle(
                          decoration: TextDecoration.underline, // 밑줄 추가
                          fontSize: 18, // 글자 크기 (옵션)
                          fontWeight: FontWeight.bold, // 글자 두께 (옵션)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
