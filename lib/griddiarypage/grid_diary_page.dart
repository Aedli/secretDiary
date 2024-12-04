import 'package:flutter/material.dart';
import 'package:mypage/diarywritepage/diary_save.dart'; // DiarySave 화면 import
import 'diary_card.dart'; // DiaryCard 위젯 import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
class GridDiary extends StatelessWidget {
  const GridDiary({super.key});

  Future<List<Map<String, dynamic>>> _fetchDiaries() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('사용자가 로그인되어 있지 않습니다.');
      }

      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('diarys')
          .get();

      if (snapshot.docs.isEmpty) {
        return [];
      }

      return snapshot.docs.map((doc) {
        return {
          "image": doc.data()["filePath"] ?? "",
          "text": doc.data()["title"] ?? "",
          "contents": doc.data()["content"] ?? "",
          "isvideo": doc.data()["isVideo"] ?? "",
        };
      }).toList();
    } catch (e) {
      throw Exception('다이어리를 가져오는 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("일기 모음"),
        automaticallyImplyLeading: false, // 화살표 뒤로가기 버튼 제거
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchDiaries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                '오류가 발생했습니다: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          final diaries = snapshot.data ?? [];

          if (diaries.isEmpty) {
            return const Center(
              child: Text(
                "다이어리가 없습니다.",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 12.0,
            ),
            itemCount: diaries.length,
            itemBuilder: (BuildContext con, int index) {
              return DiaryCard(
                imageUrl: diaries[index]["image"] as String,
                diaryTitle: diaries[index]["text"] as String,
                onTap: () {
                  Navigator.push(
                    con,
                    MaterialPageRoute(
                      builder: (context) => DiarySave(
                        title: diaries[index]["text"] as String,
                        body: diaries[index]["contents"] as String,
                        imageUrl: diaries[index]["image"] as String,
                        isVideo: diaries[index]["isvideo"] as bool,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
