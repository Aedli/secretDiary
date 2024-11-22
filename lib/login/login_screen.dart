import 'package:flutter/material.dart';
import '../constants.dart'; // constants.dart 파일 import
import '../show_dialog.dart'; // show_dialog.dart 파일 import
import '../routes.dart'; // routes.dart 파일 import

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: const Center(
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0), // 내부 여백
        decoration: BoxDecoration(
          color: AppConstants.backgroundColor,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2), // 그림자 위치
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 자식 요소에 맞춰 최소 크기로 설정
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: '이메일',
                hintText: 'aaa@example.com',
                hintStyle: TextStyle(color: AppConstants.hintColor), // 힌트 색상
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16), // 입력 필드 간격
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: '비밀번호',
                labelStyle: AppConstants.labelTextStyle, // 레이블 텍스트 스타일
              ),
              obscureText: true, // 비밀번호 입력 시 숨김 처리
            ),
            const SizedBox(height: 20), // 입력 필드와 버튼 간격
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _signIn(context); // context를 전달
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryColor, // 버튼 색상
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            AppConstants.borderRadius), // 모서리 둥글게 설정
                      ),
                    ),
                    child: const Text(
                      '로그인',
                      style: TextStyle(
                          color: AppConstants.buttonTextColor), // 버튼 텍스트 색상
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10), // 버튼 간격
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    _navigateToForgotScreen(context); // context를 전달
                  },
                  child: const Text('아이디&비밀번호 찾기'),
                ),
                TextButton(
                  onPressed: () {
                    _navigateToSignUpScreen(context); // context를 전달
                  },
                  child: const Text('회원가입'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _signIn(BuildContext context) {
    String email = _emailController.text;
    String password = _passwordController.text;

    // 이메일과 비밀번호가 각각 상수와 일치할 때 로그인 성공
    if (email == UserInfo.validID && password == UserInfo.validPassword) {
      showSuccessDialog(context, Message.loginSuccessMessage, () {
        // 성공적으로 로그인 후 AccountPage로 이동
        Navigator.pushReplacementNamed(context, AppRoutes.account); // 라우트를 사용하여 AccountPage로 이동
      });
    } else {
      showErrorDialog(context, Message.loginErrorMessage); // context 전달
    }
  }

  void _navigateToForgotScreen(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.forgotPassword);
  }

  void _navigateToSignUpScreen(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signUp);
  }
}
