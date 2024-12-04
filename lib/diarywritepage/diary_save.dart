import 'package:flutter/material.dart';
import 'package:mypage/diarywritepage/diary_write_page.dart'; // DiaryWritePage 임포트
import 'dart:io';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mypage/routes.dart';
class DiarySave extends StatelessWidget {
  final String title;
  final String body;
  final File? file;
  final String? imageUrl;
  final bool? isVideo;
  const DiarySave({Key? key, required this.title, required this.body, this.file, this.imageUrl, this.isVideo})
      : super(key: key);

  Future<void> _deleteDiary(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception('사용자가 로그인되어 있지 않습니다.');
      }

      final diaryId = title.replaceAll(' ', '_'); // Firestore에서 ID로 사용했던 title 기반 ID

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('diarys')
          .doc(diaryId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('다이어리가 삭제되었습니다.'),
          backgroundColor: Colors.green,
        ),
      );
      //삭제하고 나서 새로고침(안하면 삭제된게 보임)
      Navigator.pushReplacementNamed(context, AppRoutes.tapPage);
    } catch (e) {
      // 에러 발생 시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('삭제 중 오류가 발생했습니다: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("삭제 확인"),
          content: const Text("정말로 삭제하시겠습니까?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 다이얼로그 닫기
              },
              child: const Text("취소"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 다이얼로그 닫기
                _deleteDiary(context); // 다이어리 삭제
              },
              child: const Text("확인"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('저장 완료'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.tapPage); // 원하는 경로로 이동
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            SizedBox(height: 16),
            if (file != null)
              file!.path.endsWith('.mp4')
                  ? AspectRatio(
                aspectRatio:  6/6,
                child: VideoPlayer(VideoPlayerController.file(file!)
                  ..initialize().then((_) {})),
              )
                  : Image.file(
                file!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            if (imageUrl != null)
              isVideo!=false// imageUrl.endsWith('.mp4')로 하니까 오류
                  ? AspectRatio(
                aspectRatio: 6 / 6,
                child: VideoPlayer(VideoPlayerController.networkUrl(Uri.parse(imageUrl!))
                    ..initialize().then((_) {})),
              )

                  : Image.network(
                imageUrl!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),



            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(body, style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 16),
            // 수정 및 삭제 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DiaryWritePage(
                          initialTitle: title,
                          initialBody: body,
                          initialUrl: imageUrl,
                        ),
                      ),
                    );
                  },
                  child: const Text('수정'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showDeleteDialog(context); // 삭제 다이얼로그 호출
                  },
                  child: const Text('삭제'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}