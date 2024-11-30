import 'package:flutter/material.dart';
import '../models/user_model.dart'; // UserModel 임포트
import '../widgets/find_username_box.dart'; // 아이디 찾기 박스 위젯 임포트
import '../widgets/reset_password_box.dart'; // 비밀번호 재설정 박스 위젯 임포트

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
            FindUsernameBox(
              nameController: _nameController,
              contactController: _contactController,
              usernameNotifier: _usernameNotifier,
              usernameErrorNotifier: _usernameErrorNotifier,
              onFindUsername: () => _findUsername(context),
            ),
            const SizedBox(height: 20),
            // 비밀번호 재설정 박스
            ResetPasswordBox(
              usernameController: _usernameController,
              passwordNotifier: _passwordNotifier,
              passwordErrorNotifier: _passwordErrorNotifier,
              onResetPassword: () => _resetPassword(context, _usernameController.text.trim()),
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

    // UserModel을 사용하여 아이디 찾기
    UserModel userModel = UserModel(name: name, contact: contact);
    String? userId = await userModel.findUsername();

    if (userId != null) {
      _usernameNotifier.value = userId; // 아이디 업데이트
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
      await UserModel.resetPassword(email); // UserModel을 사용하여 비밀번호 재설정
      _passwordNotifier.value = '비밀번호 재설정 이메일이 전송되었습니다.';
      _passwordErrorNotifier.value = ''; // 오류 메시지 초기화
    } on Exception catch (e) {
      _passwordErrorNotifier.value = '오류 발생: ${e.toString()}'; // 오류 메시지
    }
  }
}
