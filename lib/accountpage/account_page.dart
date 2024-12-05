import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../secretnumchange/secretnum_change.dart';
import 'package:mypage/memberdelete/deletemeber.dart';
import '../constants.dart'; // constants.dart 파일 임포트

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String displayName = user?.displayName ?? 'Unknown';
    String email = user?.email ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(
        title: const Text('계정 페이지'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAccountInfoSection(displayName, email),
            const SizedBox(height: 20),
            _buildAccountSettingsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountInfoSection(String displayName, String email) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppConstants.backgroundColor, // 배경색을 명암 없이 흰색으로 설정
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // 외곽선 그림자 색상
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2), // 아래쪽으로 그림자 위치
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('계정 정보', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.person, size: 24),
              const SizedBox(width: 8),
              Text('이름: $displayName', style: TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.email, size: 24),
              const SizedBox(width: 8),
              Text('아이디: $email', style: TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSettingsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppConstants.backgroundColor, // 배경색을 명암 없이 흰색으로 설정
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // 외곽선 그림자 색상
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2), // 아래쪽으로 그림자 위치
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('계정 설정', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecretNumChange()),
              );
            },
            child: _buildOptionRow(Icons.settings, '비밀번호 변경'),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeleteMember()),
              );
            },
            child: _buildOptionRow(Icons.highlight_off, '회원탈퇴'),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionRow(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 24),
        const SizedBox(width: 8),
        Text(title, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
