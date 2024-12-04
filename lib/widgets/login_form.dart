import 'package:flutter/material.dart';
import '../constants.dart'; // constants.dart 파일 임포트

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function(BuildContext) onSignIn; // 로그인 함수 콜백
  final VoidCallback onNavigateToForgot; // 비밀번호 찾기 함수 콜백
  final VoidCallback onNavigateToSignUp; // 회원가입 함수 콜백

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onSignIn,
    required this.onNavigateToForgot,
    required this.onNavigateToSignUp,
  });

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
              controller: emailController,
              decoration: const InputDecoration(
                labelText: '이메일',
                hintText: 'aaa@example.com',
                hintStyle: TextStyle(color: AppConstants.hintColor), // 힌트 색상
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16), // 입력 필드 간격
            TextField(
              controller: passwordController,
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
                      onSignIn(context); // 로그인 함수 호출
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
                  onPressed: onNavigateToForgot, // 비밀번호 찾기 함수 호출
                  child: const Text('아이디 찾기&비밀번호 재설정'),
                ),
                TextButton(
                  onPressed: onNavigateToSignUp, // 회원가입 함수 호출
                  child: const Text('회원가입'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
