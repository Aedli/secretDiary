import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String name;
  final String contact;

  UserModel({required this.name, required this.contact});

  // 아이디 찾기 함수
  Future<String?> findUsername() async {
    // Firestore에서 사용자 정보 조회
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: name)
        .where('phone', isEqualTo: contact)
        .get();

    // 사용자 정보가 일치하는지 확인
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first['email']; // 이메일을 아이디로 가정
    }
    return null; // 일치하는 사용자가 없을 경우 null 반환
  }

  // 비밀번호 재설정 함수
  static Future<void> resetPassword(String email) async {
    if (email.isEmpty) {
      throw Exception('이메일을 입력하세요.'); // 오류 메시지
    }

    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
