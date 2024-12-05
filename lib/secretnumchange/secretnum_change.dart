import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart'; // constants.dart 파일 임포트

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

    String currentPassword = _currentPasswordController.text;
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmNewPasswordController.text;

    if (newPassword != confirmPassword) {
      _showErrorDialog('비밀번호가 일치하지 않습니다.');
      return;
    }

    if (newPassword.isEmpty || currentPassword.isEmpty) {
      _showErrorDialog('비밀번호를 모두 입력하세요.');
      return;
    }

    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      _showSuccessDialog('비밀번호가 성공적으로 변경되었습니다.');
    } on FirebaseAuthException catch (e) {
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
        title: const Text('비밀번호 변경'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 회원 수정 Text
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Text(
                    '비밀번호 변경',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 기존 비밀번호
              _buildPasswordField('기존 비밀번호', _currentPasswordController),
              const SizedBox(height: 20),

              // 신규 비밀번호
              _buildPasswordField('신규 비밀번호', _newPasswordController),
              const SizedBox(height: 20),

              // 비밀번호 확인
              _buildPasswordField('신규 비밀번호 확인', _confirmNewPasswordController),
              const SizedBox(height: 20),

              // 버튼들
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppConstants.buttonTextColor,
                      backgroundColor: AppConstants.primaryColor, // 버튼 텍스트 색상
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Back 버튼 클릭 시 뒤로 가기
                    },
                    child: const Text('Back'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppConstants.buttonTextColor,
                      backgroundColor: AppConstants.primaryColor, // 버튼 텍스트 색상
                    ),
                    onPressed: _changePassword, // 수정 버튼 클릭 시 비밀번호 변경
                    child: const Text('수정'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: '비밀번호 입력',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            ),
          ),
          obscureText: true,
        ),
      ],
    );
  }
}
