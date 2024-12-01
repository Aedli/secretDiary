import 'package:flutter/material.dart';
//login
import 'screens/login_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/sign_up_screen.dart';
//accountpage
import 'accountpage/account_page.dart';
import 'tappage/tapPage.dart';

class AppRoutes {
  static const String login = '/';
  static const String forgotPassword = '/forgot';
  static const String signUp = '/signup';
  static const String account = '/account';
  static const String tapPage = '/tappage';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginScreen(),
      forgotPassword: (context) => ForgotPasswordScreen(),
      signUp: (context) => SignUpScreen(),
      account: (context) => const AccountPage(),
      tapPage: (context) => const TapPage(),
    };
  }
}