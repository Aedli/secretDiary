import 'package:flutter/material.dart';

class AppConstants {
  static const Color primaryColor = Color(0xFF87CEEB); // 기본 버튼 색상
  static const Color backgroundColor = Colors.white; // 배경 색상
  static const Color hintColor = Colors.grey; // 힌트 색상
  static const Color buttonTextColor = Colors.white; // 버튼 텍스트 색상
  static const double borderRadius = 12.0; // 둥글기
  static const TextStyle labelTextStyle = TextStyle(fontSize: 16); // 레이블 텍스트 스타일
  static const Color errorColor = Colors.red; // 오류 메시지 색상
  static const Color successColor = Colors.green; // 성공 메시지 색상

  // 추가: 명암 효과를 위한 색상
  static const Color boxShadowColor = Color(0xFFB0BEC5); // 그림자 색상
  static const Color elevatedBoxColor = Color(0xFFECEFF1); // 박스 배경 색상

  static const TextStyle errorMessageStyle = TextStyle(color: Colors.red);
  static const TextStyle successMessageStyle = TextStyle(color: Colors.green);
}

class Message {
  // 에러 및 성공 메시지
  static const String loginSuccessMessage = '로그인 성공!';
  static const String loginErrorMessage = '이메일 또는 비밀번호가 잘못되었습니다.';
}

class UserInfo {
  // 사용자 정보
  static const String userName = 'abc'; // 이름
  static const String userContact = '010-1111-1111'; // 연락처
  static const String validID = '1111'; // 유효한 아이디
  static const String validPassword = '1111'; // 유효한 비밀번호
  static const String favoriteFood = 'cba'; // 좋아하는 음식
}

class HintText {
  // 힌트 텍스트
  static const String name = '홍길동';
  static const String phone = '예: 010-xxxx-xxxx';
  static const String email = 'aaa@example.com';
  static const String password = '비밀번호를 입력하세요';
  static const String confirmPassword = '비밀번호를 다시 입력하세요';
  static const String favoriteFood = '빅맥';
}
