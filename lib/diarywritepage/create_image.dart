import 'dart:io';
import 'package:image_picker/image_picker.dart';
class CreateModel {
  final _picker = ImagePicker();
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

}
