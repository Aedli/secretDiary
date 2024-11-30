import 'package:flutter/material.dart';
import '../constants.dart'; // constants.dart 파일 임포트
import '../show_dialog.dart'; // show_dialog.dart 파일 임포트
import '../routes.dart'; // routes.dart 파일 임포트
import '../models/user_model.dart'; // UserModel 임포트

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserModel _userModel = UserModel(); // UserModel 인스턴스 생성

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
                        borderRadius: BorderRadius.circular(AppConstants.borderRadius), // 모서리 둥글게 설정
                      ),
                    ),
                    child: const Text(
                      '로그인',
                      style: TextStyle(color: AppConstants.buttonTextColor), // 버튼 텍스트 색상
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

  void _signIn(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // UserModel을 사용하여 로그인 시도
    final userCredential = await _userModel.signIn(email, password);

    if (userCredential != null) {
      // Firestore에서 사용자 이름 가져오기
      String? userName = await _userModel.getUserName(userCredential.user?.uid ?? '');

      if (userName != null) {
        showSuccessDialog(context, '$userName님 반갑습니다!', () {
          Navigator.pushReplacementNamed(context, AppRoutes.tapPage); // TapPage로 이동
        });
      } else {
        showErrorDialog(context, '사용자 정보를 찾을 수 없습니다.');
      }
    } else {
      showErrorDialog(context, '로그인 중 오류가 발생했습니다.'); // 로그인 실패 시 에러 처리
    }
  }

  void _navigateToForgotScreen(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.forgotPassword);
  }

  void _navigateToSignUpScreen(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signUp);
  }
}
