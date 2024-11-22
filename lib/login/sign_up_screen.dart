import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart'; // constants.dart 파일 import
import '../show_dialog.dart';
import '../routes.dart'; // routes.dart 파일 import
class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  final TextEditingController _favoriteFoodController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SignUpForm(
            nameController: _nameController,
            phoneController: _phoneController,
            emailController: _emailController,
            passwordController: _passwordController,
            confirmPasswordController: _confirmPasswordController,
            favoriteFoodController: _favoriteFoodController,
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.favoriteFoodController,
  });

  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController favoriteFoodController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: '이름',
                  hintText: HintText.name,
                ),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: '전화번호',
                  hintText: HintText.phone,
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[\d-]'),
                  ),
                  LengthLimitingTextInputFormatter(13),
                ],
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: '이메일',
                  hintText: HintText.email,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: '비밀번호',
                  hintText: HintText.password,
                ),
                obscureText: true,
              ),
              TextField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: '비밀번호 확인',
                  hintText: HintText.confirmPassword,
                ),
                obscureText: true,
              ),
              TextField(
                controller: favoriteFoodController,
                decoration: const InputDecoration(
                  labelText: '가장 좋아하는 음식',
                  hintText: HintText.favoriteFood,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              _signUp(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              ),
            ),
            child: const Text(
              '가입하기',
              style: TextStyle(color: AppConstants.buttonTextColor),
            ),
          ),
        ),
      ],
    );
  }

  void _signUp(BuildContext context) {
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    String favoriteFood = favoriteFoodController.text.trim();

    // 이름 입력 확인
    if (name.isEmpty) {
      showErrorDialog(context, HintText.name); // 수정된 부분
      return;
    }

    // 전화번호 형식 검사
    RegExp phoneRegExp = RegExp(r'^(010-\d{4}-\d{4})$');
    // 이메일 형식 검사
    RegExp emailRegExp =
    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (!phoneRegExp.hasMatch(phone)) {
      showErrorDialog(context, HintText.phone); // 수정된 부분
      return;
    }

    if (!emailRegExp.hasMatch(email)) {
      showErrorDialog(context, HintText.email); // 수정된 부분
      return;
    }

    if (password.isEmpty || confirmPassword.isEmpty) {
      showErrorDialog(context, HintText.password); // 수정된 부분
      return;
    }

    if (password != confirmPassword) {
      showErrorDialog(context, HintText.confirmPassword); // 수정된 부분
      return;
    }

    // 가장 좋아하는 음식 입력 확인
    if (favoriteFood.isEmpty) {
      showErrorDialog(context, HintText.favoriteFood); // 수정된 부분
      return;
    }

    // 성공적으로 회원가입이 완료된 경우
    showSuccessDialog(context, '회원가입이 완료되었습니다!', () {
      // 사용자가 확인 버튼을 클릭했을 때 로그인 화면으로 이동
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    });
  }
}
