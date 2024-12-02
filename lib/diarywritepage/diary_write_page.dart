import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:mypage/diarywritepage/create_image.dart';
import 'package:mypage/diarywritepage/diary_save.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
class DiaryWritePage extends StatefulWidget {
  final String? initialTitle;
  final String? initialBody;
  final File? initialFile;
  const DiaryWritePage({Key? key, this.initialTitle, this.initialBody, this.initialFile})
      : super(key: key);

  @override
  _DiaryWritePageState createState() => _DiaryWritePageState();
}
class _DiaryWritePageState extends State<DiaryWritePage> {
  late TextEditingController _titleController;
  late TextEditingController _bodyController;
  File? _file;
  VideoPlayerController? _videoController; // 동영상 재생 컨트롤러
  final model = CreateModel();
  FirebaseFirestore _firestore=FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _bodyController = TextEditingController(text: widget.initialBody);
    _file = widget.initialFile; // 초기 파일 설정
    if (_file != null && _file!.path.endsWith('.mp4')) {
      _videoController = VideoPlayerController.file(_file!)
        ..initialize().then((_) {
          setState(() {});
        }).catchError((error) {
          print("동영상 초기화 실패: $error");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('동영상 초기화에 실패했습니다: $error')),
          );
        });
    }
  }
  String? getCurrentUserId() {
    final User? user = _auth.currentUser; // 현재 로그인한 사용자 가져오기
    return user?.uid; // 사용자 ID (로그인하지 않았으면 null 반환)
  }
  @override
  void dispose() {
    _videoController?.dispose(); // 비디오 컨트롤러 해제
    super.dispose();
  }
  // Storage 관련 패키지

  Future<void> _saveEntry() async {
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

    try {
      // 로그인된 사용자 ID 가져오기
      String? userId = getCurrentUserId();
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('사용자가 로그인되어 있지 않습니다.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // 다이어리 문서 ID 생성
      String diaryId = title.replaceAll(' ', '_'); // 제목 기반 ID 생성

      // Firebase Storage 참조 생성
      String? imageUrl;
      if (_file != null && !_file!.path.endsWith('.mp4')) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('users/$userId/diarys/$diaryId/image_${DateTime.now().millisecondsSinceEpoch}.jpg');

        // 이미지가 이미 업로드되었는지 확인
        final existingDoc = await _firestore
            .collection('users')
            .doc(userId)
            .collection('diarys')
            .doc(diaryId)
            .get();

        if (!existingDoc.exists || existingDoc['filePath'] == null) {
          // 파일 업로드
          UploadTask uploadTask = storageRef.putFile(_file!);
          final snapshot = await uploadTask.whenComplete(() {});
          imageUrl = await snapshot.ref.getDownloadURL();
        } else {
          // 기존 이미지 URL 사용
          imageUrl = existingDoc['filePath'];
        }
      }

      // Firestore에 다이어리 저장
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('diarys')
          .doc(diaryId)
          .set({
        'title': title,
        'content': body,
        'filePath': imageUrl,
        'updatedAt': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('다이어리가 성공적으로 저장되었습니다!'),
          backgroundColor: Colors.green,
        ),
      );

      _titleController.clear();
      _bodyController.clear();
      setState(() {
        _file = null;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DiarySave(
            title: title,
            body: body,
            file: _file,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('저장 중 오류가 발생했습니다: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
                      width: 150,
                      height: 200,
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
                height: 200,
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

