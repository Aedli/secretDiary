import 'package:flutter/material.dart';
import 'package:mypage/diarywritepage/diary_write_page.dart';
class DiarySave extends StatelessWidget {
  final String title;
  final String body;

  const DiarySave({Key? key, required this.title, required this.body})
      : super(key: key);
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("삭제 확인"),
          content: Text("정말로 삭제하시겠습니까?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 다이얼로그 닫기
              },
              child: Text("취소"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 다이얼로그 닫기
                Navigator.pop(context); // 메인 화면으로 이동
              },
              child: Text("확인"),
            ),
          ],
        );
      },
    );
  }
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('저장 완료'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   '저장된 제목:',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            //SizedBox(height: 8),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 25)),
            SizedBox(height: 16),
            Image.asset(
              'assets/images/test1.jpg',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            // Text(
            //   '저장된 내용:',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(body, style: TextStyle(fontSize: 16)),
              ),
            ),
            SizedBox(height: 16),

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
                        ),
                      ),
                    );
                  },
                  child: Text('수정'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showDeleteDialog(context); // 삭제 다이얼로그 호출
                  },
                  child: Text('삭제'),
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
