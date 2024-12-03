import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
class CreateModel {
  final _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  // 사진 선택
  Future<File?> getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    }
    return File(image.path);
  }

  // 동영상 선택
  Future<File?> getVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video == null) {
      return null;
    }
    return File(video.path);
  }
  // /// Firebase Storage에 이미지를 업로드하는 함수
  // Future<String> uploadImage(File imageFile) async {
  //   try {
  //     final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //     final Reference ref = _storage.ref().child('images/$fileName.jpg');
  //
  //     final UploadTask uploadTask = ref.putFile(imageFile);
  //     final TaskSnapshot snapshot = await uploadTask;
  //
  //     // 업로드된 파일의 다운로드 URL 반환
  //     return await snapshot.ref.getDownloadURL();
  //   } catch (e) {
  //     throw Exception('이미지 업로드에 실패했습니다: $e');
  //   }
  // }
  //
  // /// Firebase Storage에 비디오를 업로드하는 함수
  // Future<String> uploadVideo(File videoFile) async {
  //   try {
  //     final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //     final Reference ref = _storage.ref().child('videos/$fileName.mp4');
  //
  //     final UploadTask uploadTask = ref.putFile(videoFile);
  //     final TaskSnapshot snapshot = await uploadTask;
  //
  //     // 업로드된 파일의 다운로드 URL 반환
  //     return await snapshot.ref.getDownloadURL();
  //   } catch (e) {
  //     throw Exception('비디오 업로드에 실패했습니다: $e');
  //   }
  // }
}
