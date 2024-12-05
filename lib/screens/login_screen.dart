import 'package:flutter/material.dart';
import '../constants.dart';
import '../routes.dart';
import '../show_dialog.dart';
import '../widgets/login_form.dart'; // LoginForm 위젯 임포트
import '../models/user_model.dart'; // UserModel 임포트

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserModel _userModel = UserModel(); // UserModel 인스턴스 생성

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: SingleChildScrollView( // 스크롤 가능하게 변경
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 둥글게 처리된 사각형으로 이미지 추가
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppConstants.elevatedBoxColor, // 배경 색상
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius), // 둥글기
                    boxShadow: const [
                      BoxShadow(
                        color: AppConstants.boxShadowColor,
                        blurRadius: 10.0,
                        offset: Offset(0, 5), // 그림자 위치
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius), // 둥글기 적용
                    child: Image.asset(
                      'assets/images/mydiary.png',
                      height: 150, // 원하는 높이로 조정
                      width: 320,  // 원하는 너비로 조정
                      fit: BoxFit.cover, // 이미지 비율 유지
                    ),
                  ),
                ),
              ),
              // 이미지와 LoginForm 사이에 간격 추가
              const SizedBox(height: 20), // 원하는 간격으로 조정

              // LoginForm 위젯
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0), // 좌우 패딩 추가
                child: LoginForm(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  onSignIn: (context) => _signIn(context), // 로그인 함수 전달
                  onNavigateToForgot: () => _navigateToForgotScreen(context), // 비밀번호 찾기 함수 전달
                  onNavigateToSignUp: () => _navigateToSignUpScreen(context), // 회원가입 함수 전달
                ),
              ),
              const SizedBox(height: 20), // 추가적인 간격 조정
            ],
          ),
        ),
      ),
    );
  }

  void _signIn(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // 이메일 입력 확인
    if (email.isEmpty) {
      showErrorDialog(context, '이메일을 입력하세요.'); // 이메일이 비어있을 때
      return;
    }

    // 이메일 형식 확인
    RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegExp.hasMatch(email)) {
      showErrorDialog(context, '이메일 형식이 올바르지 않습니다.'); // 이메일 형식이 유효하지 않을 때
      return;
    }

    // 비밀번호 입력 확인
    if (password.isEmpty) {
      showErrorDialog(context, '비밀번호를 입력하세요.'); // 비밀번호가 비어있을 때
      return;
    }

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
        showErrorDialog(context, '사용자 정보를 찾을 수 없습니다.'); // 사용자가 없을 경우
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
