import 'package:flutter/material.dart';
import 'routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 엔진 초기화

  try {
    await dotenv.load(fileName: ".env"); // .env 파일 로드
    await Firebase.initializeApp( // Firebase 초기화
      options: DefaultFirebaseOptions.currentPlatform, // 현재 플랫폼에 맞는 Firebase 옵션 사용
    );
    runApp(const MyApp()); // 애플리케이션 실행
  } catch (e) {
    // 에러 핸들링: Firebase 초기화 또는 .env 파일 로드 실패 시
    print("앱 초기화 중 오류 발생: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secret Diary',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), // 색상 테마 설정
        useMaterial3: true, // Material 3 사용 설정
      ),
      initialRoute: AppRoutes.login, // 초기 화면 설정
      routes: AppRoutes.getRoutes(), // 라우트 설정
    );
  }
}
