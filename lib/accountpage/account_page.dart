import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../secretnumchange/secretnum_change.dart';
import 'package:mypage/memberdelete/deletemeber.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 현재 로그인한 사용자 가져오기
    User? user = FirebaseAuth.instance.currentUser;

    // 사용자 이름과 이메일, 이름은 디스플레이네임에 저장될 수 있음
    String displayName = user?.displayName ?? 'Unknown';
    String email = user?.email ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(
        title: Text('계정 페이지'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 8),
              const Icon(Icons.send),
              const SizedBox(width: 8),
              Text('이름: $displayName'),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 8),
              const Icon(Icons.favorite_border),
              const SizedBox(width: 8),
              Text('아이디: $email'),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(color: Colors.grey, thickness: 1, indent: 16, endIndent: 16),
          const Text('   계정정보'),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecretNumChange()),
              );
            },
            child: Row(
              children: const [
                SizedBox(width: 8),
                Icon(Icons.settings),
                SizedBox(width: 8),
                Text('비밀번호 변경'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeleteMember()),
              );
            },
            child: Row(
              children: const [
                SizedBox(width: 8),
                Icon(Icons.highlight_off),
                SizedBox(width: 8),
                Text('회원탈퇴'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}