import 'package:flutter/material.dart';
import '../widgets/login_form.dart'; // LoginForm 위젯 임포트

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: const Center(
        child: LoginForm(), // LoginForm 위젯 사용
      ),
    );
  }
}