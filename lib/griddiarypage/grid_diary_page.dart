import 'package:flutter/material.dart';
import 'package:mypage/diarywritepage/diary_save.dart'; // DiarySave 화면 import

class GridDiary extends StatelessWidget {
  const GridDiary({super.key});

  @override
  Widget build(BuildContext context) {
    // 이미지와 텍스트를 저장한 리스트
    final List<Map<String, String>> items = [
      {"image": "assets/images/test1.jpg", "text": "제목1"},
      {"image": "assets/images/test1.jpg", "text": "제목2"},
      {"image": "assets/images/test1.jpg", "text": "제목3"},
      {"image": "assets/images/test1.jpg", "text": "제목4"},
      {"image": "assets/images/test1.jpg", "text": "제목5"},
      {"image": "assets/images/test1.jpg", "text": "제목6"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("일기 모음"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 12.0,
        ),
        itemCount: items.length,
        itemBuilder: (BuildContext con, int index) {
          return diaryContainer(
            image: items[index]["image"] as String,
            diary_title: items[index]["text"] as String,
            onTap: () {
              // DiarySave 화면으로 이동
              Navigator.push(
                con,
                MaterialPageRoute(
                  builder: (context) => DiarySave(title: "ffff", body: "fffff",),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget diaryContainer({
    required String image,
    required String diary_title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 200,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              image,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Text(
              diary_title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
