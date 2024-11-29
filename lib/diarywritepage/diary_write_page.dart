import 'package:flutter/material.dart';
import 'package:mypage/diarywritepage/diary_save.dart';
class DiaryWritePage extends StatefulWidget {
  final String? initialTitle;
  final String? initialBody;

  const DiaryWritePage({Key? key, this.initialTitle, this.initialBody})
      : super(key: key);
  @override
  _DiaryWritePageState createState() => _DiaryWritePageState();
}

class _DiaryWritePageState extends State<DiaryWritePage> {
  late TextEditingController _titleController;
  late TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    // 기존 데이터를 입력 필드에 초기화
    _titleController = TextEditingController(text: widget.initialTitle);
    _bodyController = TextEditingController(text: widget.initialBody);
  }

  void _saveEntry() {
    String title = _titleController.text.trim();
    String body = _bodyController.text.trim();

    if (title.isEmpty || body.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('제목과 내용을 모두 입력해주세요!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 화면 전환: DiarySave로 이동
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiarySave(
          title: title,
          body: body,
        ),
      ),
    );

    _titleController.clear();
    _bodyController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('다이어리 작성'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: '제목',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Image.asset(
              'assets/images/test1.jpg',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _bodyController,
                decoration: InputDecoration(
                  labelText: '글쓰기',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8),
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // 사진/영상 업로드 로직 추가
                  },
                  icon: Icon(Icons.upload),
                  label: Text('사진/영상 업로드'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                ),
                ElevatedButton(
                  onPressed: _saveEntry,
                  child: Text('저장'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
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
