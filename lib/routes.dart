import 'package:flutter/material.dart';
//login
import 'login/login_screen.dart';
import 'login/forgot_password_screen.dart';
import 'login/sign_up_screen.dart';
//accountpage
import 'accountpage/account_page.dart';

class AppRoutes {
  static const String login = '/';
  static const String forgotPassword = '/forgot';
  static const String signUp = '/signup';
  static const String account = '/account';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginScreen(),
      forgotPassword: (context) => ForgotPasswordScreen(),
      signUp: (context) => SignUpScreen(),
      account: (context) => AccountPage(),
    };
  }
}