import 'package:flutter/material.dart';
import '../constants.dart'; // constants.dart 파일 임포트

class ResetPasswordBox extends StatelessWidget {
  final TextEditingController usernameController;
  final ValueNotifier<String> passwordNotifier;
  final ValueNotifier<String> passwordErrorNotifier;
  final VoidCallback onResetPassword;

  const ResetPasswordBox({
    super.key,
    required this.usernameController,
    required this.passwordNotifier,
    required this.passwordErrorNotifier,
    required this.onResetPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            controller: usernameController,
            decoration: const InputDecoration(labelText: '아이디'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onResetPassword,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.primaryColor, // 버튼 배경색
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.borderRadius), // 버튼 모서리 둥글게
              ),
            ),
            child: const Text(
              '비밀번호 재설정',
              style: TextStyle(color: AppConstants.buttonTextColor), // 버튼 텍스트 색상
            ),
          ),
          const SizedBox(height: 10),
          ValueListenableBuilder<String>(
            valueListenable: passwordNotifier,
            builder: (context, password, child) {
              return password.isNotEmpty
                  ? Text('비밀번호 재설정 메시지: $password', style: AppConstants.successMessageStyle)
                  : Container();
            },
          ),
          ValueListenableBuilder<String>(
            valueListenable: passwordErrorNotifier,
            builder: (context, error, child) {
              return error.isNotEmpty
                  ? Text(error, style: AppConstants.errorMessageStyle)
                  : Container();
            },
          ),
        ],
      ),
    );
  }
}
