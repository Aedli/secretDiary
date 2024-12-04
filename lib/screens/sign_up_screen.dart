import 'package:flutter/material.dart';
import '../models/user_model.dart'; // UserModel 임포트
import '../widgets/sign_up_form.dart'; // SignUpForm 위젯 임포트
import '../show_dialog.dart'; // show_dialog.dart 임포트
import '../routes.dart'; // routes.dart 임포트

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
            onSignUp: (context) => _signUp(context), // 회원가입 함수 전달
          ),
        ),
      ),
    );
  }

  void _signUp(BuildContext context) async {
    String name = _nameController.text.trim();
    String phone = _phoneController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    // 이름 입력 확인
    if (name.isEmpty) {
      showErrorDialog(context, '이름을 입력하세요.');
      return;
    }

    // 전화번호 입력 확인
    if (phone.isEmpty) {
      showErrorDialog(context, '전화번호를 입력하세요.'); // 전화번호가 비어있을 때
      return;
    }

    // 전화번호 형식 검사
    RegExp phoneRegExp = RegExp(r'^(010-\d{4}-\d{4})$');
    if (!phoneRegExp.hasMatch(phone)) {
      showErrorDialog(context, '전화번호 형식이 올바르지 않습니다.');
      return;
    }

    // 이메일 입력 확인
    if (email.isEmpty) {
      showErrorDialog(context, '이메일을 입력하세요.'); // 이메일이 비어있을 때
      return;
    }

    // 이메일 형식 검사
    RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegExp.hasMatch(email)) {
      showErrorDialog(context, '이메일 형식이 올바르지 않습니다.');
      return;
    }

    // 비밀번호 입력 확인
    if (password.isEmpty) {
      showErrorDialog(context, '비밀번호를 입력하세요.'); // 비밀번호가 비어있을 때
      return;
    }

    // 비밀번호 형식 검사 (6자 이상)
    if (password.length < 6) {
      showErrorDialog(context, '비밀번호는 6자 이상이어야 합니다.'); // 길이 조건 검사
      return;
    }

    // 비밀번호 확인 입력 확인
    if (confirmPassword.isEmpty) {
      showErrorDialog(context, '비밀번호 확인을 입력하세요.'); // 비밀번호 확인이 비어있을 때
      return;
    }

    // 비밀번호와 비밀번호 확인 일치 확인
    if (password != confirmPassword) {
      showErrorDialog(context, '비밀번호가 일치하지 않습니다.');
      return;
    }

    // UserModel을 사용하여 사용자 등록
    UserModel userModel = UserModel();
    final userCredential = await userModel.signUp(email, password, name, phone);

    if (userCredential != null) {
      showSuccessDialog(context, '회원가입이 완료되었습니다!', () {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      });
    } else {
      showErrorDialog(context, '회원가입 중 오류가 발생했습니다.');
    }
  }
}
