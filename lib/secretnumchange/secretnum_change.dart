import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SecretNumChange extends StatefulWidget {
  const SecretNumChange({super.key});

  @override
  _SecretNumChangeState createState() => _SecretNumChangeState();
}

class _SecretNumChangeState extends State<SecretNumChange> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 비밀번호 변경 함수
  Future<void> _changePassword() async {
    User? user = _auth.currentUser;

    // 비밀번호가 일치하는지 확인
    String currentPassword = _currentPasswordController.text;
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmNewPasswordController.text;

    // 비밀번호가 일치하지 않으면 알림
    if (newPassword != confirmPassword) {
      _showErrorDialog('비밀번호가 일치하지 않습니다.');
      return;
    }

    // 비밀번호가 비어있으면 알림
    if (newPassword.isEmpty || currentPassword.isEmpty) {
      _showErrorDialog('비밀번호를 모두 입력하세요.');
      return;
    }

    try {
      // 사용자 인증 확인
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: currentPassword,
      );

      // 기존 비밀번호로 사용자 재인증
      await user.reauthenticateWithCredential(credential);

      // 비밀번호 변경
      await user.updatePassword(newPassword);

      // 비밀번호 변경 성공 후 알림
      _showSuccessDialog('비밀번호가 성공적으로 변경되었습니다.');
    } on FirebaseAuthException catch (e) {
      // 오류 처리
      if (e.code == 'wrong-password') {
        _showErrorDialog('기존 비밀번호가 틀렸습니다.');
      } else {
        _showErrorDialog('비밀번호 변경에 실패했습니다. 다시 시도해주세요.');
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

  // 성공 메시지 Dialog
  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('성공'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Dialog 닫기
                Navigator.pop(context); // 이전 페이지로 돌아가기
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
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 회원 수정 Text
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Text(
                    '회원 수정',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // 기존 비밀번호
              Text('기존 비밀번호'),
              TextFormField(
                controller: _currentPasswordController,
                decoration: InputDecoration(
                  hintText: '기존 비밀번호 입력',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),

              // 신규 비밀번호
              Text('신규 비밀번호'),
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  hintText: '신규 비밀번호 입력',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),

              // 비밀번호 확인
              Text('신규 비밀번호 확인'),
              TextFormField(
                controller: _confirmNewPasswordController,
                decoration: InputDecoration(
                  hintText: '신규 비밀번호 확인 입력',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),

              // 버튼들
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.blue, // 버튼 텍스트 색 변경
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Back 버튼 클릭 시 뒤로 가기
                    },
                    child: Text('Back'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.blue, // 버튼 텍스트 색 변경
                    ),
                    onPressed: _changePassword, // 수정 버튼 클릭 시 비밀번호 변경
                    child: Text('수정'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}