import 'package:flutter/material.dart';
import '../constants.dart'; // constants.dart 파일 import

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _favoriteFoodController = TextEditingController();

  // ValueNotifiers
  final ValueNotifier<String> _usernameNotifier = ValueNotifier('');
  final ValueNotifier<String> _usernameErrorNotifier =
  ValueNotifier(''); // 아이디 찾기 오류
  final ValueNotifier<String> _passwordNotifier = ValueNotifier('');
  final ValueNotifier<String> _passwordErrorNotifier =
  ValueNotifier('');

  ForgotPasswordScreen({super.key}); // 비밀번호 찾기 오류

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('아이디&비밀번호 찾기'),
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
            // 비밀번호 찾기 박스
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
                  TextField(
                    controller: _favoriteFoodController,
                    decoration: const InputDecoration(labelText: '가장 좋아하는 음식'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _findPassword(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryColor, // 버튼 배경색
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            AppConstants.borderRadius), // 버튼 모서리 둥글게
                      ),
                    ),
                    child: const Text(
                      '비밀번호 찾기',
                      style: TextStyle(
                          color: AppConstants.buttonTextColor), // 버튼 텍스트 색상
                    ),
                  ),
                  const SizedBox(height: 10),
                  ValueListenableBuilder<String>(
                    valueListenable: _passwordNotifier,
                    builder: (context, password, child) {
                      return password.isNotEmpty
                          ? Text('비밀번호: $password',
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
  void _findUsername(BuildContext context) {
    String name = _nameController.text;
    String contact = _contactController.text;

    // 이름과 연락처 형식 검사
    if (name.isEmpty || !RegExp(r'^(010-\d{4}-\d{4})$').hasMatch(contact)) {
      _usernameErrorNotifier.value = '이름/연락처 오류'; // 아이디 찾기 오류 메시지
      _usernameNotifier.value = '';
      return;
    }

    // 사용자 정보와 일치하는지 검사
    if (name == UserInfo.userName && contact == UserInfo.userContact) {
      // 아이디 찾기 로직 (예: 서버에서 아이디 조회)
      _usernameNotifier.value = UserInfo.validID;
      _usernameErrorNotifier.value = ''; // 오류 메시지 초기화
    } else {
      _usernameErrorNotifier.value = '이름/연락처가 일치하지 않습니다.'; // 오류 메시지
      _usernameNotifier.value = '';
    }
  }

  // 비밀번호 찾기 함수
  void _findPassword(BuildContext context) {
    String username = _usernameController.text;
    String favoriteFood = _favoriteFoodController.text;

    // 아이디와 좋아하는 음식 형식 검사
    if (username.isEmpty || favoriteFood.isEmpty) {
      _passwordErrorNotifier.value = '아이디/답변 오류'; // 비밀번호 찾기 오류 메시지
      _passwordNotifier.value = '';
      return;
    }

    // 사용자 정보와 일치하는지 검사
    if (username == UserInfo.validID &&
        favoriteFood == UserInfo.favoriteFood) {
      // 비밀번호 찾기 로직 (예: 서버에서 비밀번호 조회)
      _passwordNotifier.value = UserInfo.validPassword;
      _passwordErrorNotifier.value = ''; // 오류 메시지 초기화
    } else {
      _passwordErrorNotifier.value = '아이디/답변이 일치하지 않습니다.'; // 오류 메시지
      _passwordNotifier.value = '';
    }
  }
}
