import 'package:flutter/material.dart';
import '../constants.dart'; // constants.dart 파일 import
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore import
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  // ValueNotifiers
  final ValueNotifier<String> _usernameNotifier = ValueNotifier('');
  final ValueNotifier<String> _usernameErrorNotifier =
  ValueNotifier(''); // 아이디 찾기 오류
  final ValueNotifier<String> _passwordNotifier = ValueNotifier('');
  final ValueNotifier<String> _passwordErrorNotifier =
  ValueNotifier('');

  ForgotPasswordScreen({super.key}); // 비밀번호 재설정 오류

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('아이디&비밀번호 재설정'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView( // 스크롤 가능하도록 변경
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // 아이디 찾기 박스
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppConstants.backgroundColor,
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: '이름'),
                  ),
                  TextField(
                    controller: _contactController,
                    decoration:
                    const InputDecoration(labelText: '연락처 (예: 010-xxxx-xxxx)'),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _findUsername(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryColor, // 버튼 배경색
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            AppConstants.borderRadius), // 버튼 모서리 둥글게
                      ),
                    ),
                    child: const Text(
                      '아이디 찾기',
                      style: TextStyle(
                          color: AppConstants.buttonTextColor), // 버튼 텍스트 색상
                    ),
                  ),
                  const SizedBox(height: 10),
                  ValueListenableBuilder<String>(
                    valueListenable: _usernameNotifier,
                    builder: (context, username, child) {
                      return username.isNotEmpty
                          ? Text('아이디: $username',
                          style: AppConstants.successMessageStyle)
                          : Container();
                    },
                  ),
                  ValueListenableBuilder<String>(
                    valueListenable: _usernameErrorNotifier,
                    builder: (context, error, child) {
                      return error.isNotEmpty
                          ? Text(error, style: AppConstants.errorMessageStyle)
                          : Container();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // 비밀번호 재설정 박스
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppConstants.backgroundColor,
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: '아이디'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      String email = _usernameController.text.trim(); // 입력된 이메일 가져오기
                      _resetPassword(context, email); // 이메일을 인자로 전달
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryColor, // 버튼 배경색
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            AppConstants.borderRadius), // 버튼 모서리 둥글게
                      ),
                    ),
                    child: const Text(
                      '비밀번호 재설정',
                      style: TextStyle(
                          color: AppConstants.buttonTextColor), // 버튼 텍스트 색상
                    ),
                  ),
                  const SizedBox(height: 10),
                  ValueListenableBuilder<String>(
                    valueListenable: _passwordNotifier,
                    builder: (context, password, child) {
                      return password.isNotEmpty
                          ? Text('비밀번호 재설정 메시지: $password',
                          style: AppConstants.successMessageStyle)
                          : Container();
                    },
                  ),
                  ValueListenableBuilder<String>(
                    valueListenable: _passwordErrorNotifier,
                    builder: (context, error, child) {
                      return error.isNotEmpty
                          ? Text(error, style: AppConstants.errorMessageStyle)
                          : Container();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 아이디 찾기 함수
  void _findUsername(BuildContext context) async {
    String name = _nameController.text.trim();
    String contact = _contactController.text.trim();

    // 이름과 연락처 형식 검사
    if (name.isEmpty || !RegExp(r'^(010-\d{4}-\d{4})$').hasMatch(contact)) {
      _usernameErrorNotifier.value = '이름/연락처 오류'; // 아이디 찾기 오류 메시지
      _usernameNotifier.value = '';
      return;
    }

    // Firestore에서 사용자 정보 조회
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: name)
        .where('phone', isEqualTo: contact)
        .get();

    // 사용자 정보가 일치하는지 확인
    if (querySnapshot.docs.isNotEmpty) {
      // 아이디 찾기 로직 (예: 사용자 문서에서 아이디 가져오기)
      String userId = querySnapshot.docs.first['email']; // 이메일을 아이디로 가정
      _usernameNotifier.value = userId;
      _usernameErrorNotifier.value = ''; // 오류 메시지 초기화
    } else {
      _usernameErrorNotifier.value = '이름/연락처가 일치하지 않습니다.'; // 오류 메시지
      _usernameNotifier.value = '';
    }
  }

  // 비밀번호 재설정 함수
  Future<void> _resetPassword(BuildContext context, String email) async {
    if (email.isEmpty) {
      _passwordErrorNotifier.value = '이메일을 입력하세요.'; // 오류 메시지
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _passwordNotifier.value = '비밀번호 재설정 이메일이 전송되었습니다.';
      _passwordErrorNotifier.value = ''; // 오류 메시지 초기화
    } on FirebaseAuthException catch (e) {
      _passwordErrorNotifier.value = '오류 발생: ${e.message}'; // 오류 메시지
    }
  }
}
