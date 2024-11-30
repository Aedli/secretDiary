import 'package:flutter/material.dart';
import '../constants.dart'; // constants.dart 파일 임포트

class FindUsernameBox extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController contactController;
  final ValueNotifier<String> usernameNotifier;
  final ValueNotifier<String> usernameErrorNotifier;
  final VoidCallback onFindUsername;

  const FindUsernameBox({
    super.key,
    required this.nameController,
    required this.contactController,
    required this.usernameNotifier,
    required this.usernameErrorNotifier,
    required this.onFindUsername,
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
            controller: nameController,
            decoration: const InputDecoration(labelText: '이름'),
          ),
          TextField(
            controller: contactController,
            decoration: const InputDecoration(labelText: '연락처 (예: 010-xxxx-xxxx)'),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onFindUsername,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.primaryColor, // 버튼 배경색
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.borderRadius), // 버튼 모서리 둥글게
              ),
            ),
            child: const Text(
              '아이디 찾기',
              style: TextStyle(color: AppConstants.buttonTextColor), // 버튼 텍스트 색상
            ),
          ),
          const SizedBox(height: 10),
          ValueListenableBuilder<String>(
            valueListenable: usernameNotifier,
            builder: (context, username, child) {
              return username.isNotEmpty
                  ? Text('아이디: $username', style: AppConstants.successMessageStyle)
                  : Container();
            },
          ),
          ValueListenableBuilder<String>(
            valueListenable: usernameErrorNotifier,
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
