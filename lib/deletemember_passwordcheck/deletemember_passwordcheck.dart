import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypage/deletefinish/deletefinish.dart';
import '../constants.dart'; // constants.dart 파일 임포트
import 'package:mypage/tappage/tapPage.dart'; // TapPage 임포트 추가

class PasswordCheck extends StatefulWidget {
  const PasswordCheck({super.key});

  @override
  _PasswordCheckState createState() => _PasswordCheckState();
}

class _PasswordCheckState extends State<PasswordCheck> {
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _deleteAccount() async {
    String password = _passwordController.text;
    User? user = _auth.currentUser;

    if (password.isEmpty) {
      _showErrorDialog('비밀번호를 입력해주세요.');
      return;
    }

    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);

      final diaryCollectionRef = _firestore.collection('users').doc(user.uid).collection('diarys');
      final QuerySnapshot<Map<String, dynamic>> diarySnapshot = await diaryCollectionRef.get();

      for (var doc in diarySnapshot.docs) {
        final data = doc.data();
        final String? filePath = data['filePath'];

        if (filePath != null) {
          try {
            final storageRef = FirebaseStorage.instance.ref();
            await storageRef.child(Uri.decodeFull(filePath.split('o/')[1].split('?')[0])).delete();
          } catch (e) {
            print("파일 삭제 실패: $e");
          }
        }
        await doc.reference.delete();
      }

      await _firestore.collection('users').doc(user.uid).delete();
      await user.delete();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DeleteFinish(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        _showErrorDialog('비밀번호가 틀렸습니다.');
      } else {
        _showErrorDialog('계정 삭제에 실패했습니다. 다시 시도해주세요.');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('오류', style: TextStyle(color: AppConstants.primaryColor)),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('확인', style: TextStyle(color: AppConstants.primaryColor)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 회원 탈퇴 제목
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Text(
                    '회원 탈퇴',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 비밀번호 확인 텍스트 및 입력 필드
              const Text('비밀번호 확인', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: '비밀번호 입력',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),

              // 돌아가기 버튼
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppConstants.primaryColor,
                  ),
                  onPressed: () {
                    // TapPage로 이동하면서 AccountPage 선택
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TapPage(initialIndex: 2), // AccountPage로 가는 인덱스 설정
                      ),
                    );
                  },
                  child: const Text('돌아가기'),
                ),
              ),
              const SizedBox(height: 200), // "돌아가기" 버튼과 "탈퇴하기" 버튼 사이의 여백 증가

              // 탈퇴하기 텍스트는 그대로 두기
              Center(
                child: GestureDetector(
                  onTap: _deleteAccount,
                  child: const Text(
                    '탈퇴하기',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
