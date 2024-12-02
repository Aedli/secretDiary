import 'package:flutter/material.dart';

class DiaryCard extends StatelessWidget {
  final String imageUrl;  // URL로 받는 이미지
  final String diaryTitle;
  final VoidCallback onTap;

  const DiaryCard({
    Key? key,
    required this.imageUrl,
    required this.diaryTitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 200,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              imageUrl,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;  // 로딩 완료된 이미지 반환
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );  // 로딩 중에 원형 진행 표시기 표시
                }
              },
              errorBuilder: (context, error, stackTrace) {
                // 이미지 로드 실패 시 기본 이미지 표시
                return Image.asset(
                  'assets/images/test1.jpg',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                );
              },
            ),
            const SizedBox(height: 8),
            Text(
              diaryTitle,
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
