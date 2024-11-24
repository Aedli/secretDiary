import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:mypage/diarywritepage/create_image.dart';
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
  File? _file; // 사진 또는 동영상 파일
  VideoPlayerController? _videoController; // 동영상 재생 컨트롤러
  final model = CreateModel();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _bodyController = TextEditingController(text: widget.initialBody);
  }

  @override
  void dispose() {
    _videoController?.dispose(); // 비디오 컨트롤러 해제
    super.dispose();
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

  Future<void> _showPickOptionsDialog(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('사진 선택'),
                onTap: () async {
                  Navigator.of(context).pop();
                  _file = await model.getImage();
                  _videoController?.dispose(); // 기존 비디오 컨트롤러 해제
                  _videoController = null; // 비디오 컨트롤러 초기화
                  setState(() {});
                },
              ),
              ListTile(
                leading: Icon(Icons.videocam),
                title: Text('동영상 선택'),
                onTap: () async {
                  Navigator.of(context).pop();
                  _file = await model.getVideo();
                  if (_file != null) {
                    print("선택된 동영상 경로: ${_file!.path}");
                    _videoController?.dispose(); // 기존 비디오 컨트롤러 해제
                    _videoController = VideoPlayerController.file(_file!)
                      ..initialize().then((_) {
                        print("동영상 초기화 성공");
                        setState(() {});
                      }).catchError((error) {
                        print("동영상 초기화 실패: $error");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('동영상 초기화에 실패했습니다: $error')),
                        );
                      });
                  } else {
                    print("동영상 선택 실패");
                  }
                },
              ),
            ],
          ),
        );
      },
    );
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
            if (_file != null)
              _file!.path.endsWith('.mp4') && _videoController != null
                  ? Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_videoController!.value.isPlaying) {
                          _videoController!.pause();
                        } else {
                          _videoController!.play();
                        }
                      });
                    },
                    child: Container(
                      width: 150, // 비디오의 가로 크기 제한
                      height: 200, // 비디오의 세로 크기 제한
                      child: AspectRatio(
                        aspectRatio: _videoController!.value.aspectRatio,
                        child: VideoPlayer(_videoController!),
                      ),
                    ),
                  ),
                ],
              )
                  : Image.file(
                _file!,
                width: 300,
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
                  onPressed: () async {
                    await _showPickOptionsDialog(context);
                  },
                  icon: Icon(Icons.upload),
                  label: Text('업로드'),
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

