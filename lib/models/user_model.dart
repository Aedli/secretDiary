import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final FirebaseAuth _auth = FirebaseAuth.instance; // FirebaseAuth 인스턴스 생성
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore 인스턴스 생성

  // 사용자 등록 함수
  Future<UserCredential?> signUp(String email, String password, String name, String phone) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateProfile(displayName: name);  // displayName을 name으로 설정

      // Firestore에 사용자 정보 저장
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'name': name,
        'phone': phone,
        'email': email,
      });
      return userCredential; // 사용자 정보 반환
    } on FirebaseAuthException catch (e) {
      // 예외 처리
      print('회원가입 오류: ${e.message}');
      return null;
    }
  }



  // 로그인 함수
  Future<UserCredential?> signIn(String email, String password) async {
    try {
      // Firebase Auth를 통한 로그인 시도
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // 로그인 실패 시 예외 처리
      print('로그인 오류: ${e.message}');
      return null; // 로그인 실패 시 null 반환
    }
  }

  // Firestore에서 사용자 이름 가져오기
  Future<String?> getUserName(String userId) async {
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
    if (userDoc.exists) {
      return userDoc['name']; // Firestore에서 이름 가져오기
    }
    return null; // 사용자 정보가 없을 경우 null 반환
  }

  // 아이디 찾기 함수 (name과 contact을 매개변수로 받음)
  Future<String?> findUsername(String name, String contact) async {
    // Firestore에서 사용자 정보 조회
    QuerySnapshot querySnapshot = await _firestore
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