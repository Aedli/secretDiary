import 'package:flutter/material.dart';
import 'routes.dart'; // routes.dart 파일 import
// todo Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 엔진 초기화
  try {
    await dotenv.load(fileName: ".env"); // .env 파일 로드
    await Firebase.initializeApp( // Firebase 초기화
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp()); // 애플리케이션 실행
  } catch (e) {
    // 에러 핸들링: Firebase 초기화 또는 .env 파일 로드 실패 시
    print("Error initializing app: $e");
    // 필요에 따라 앱을 종료하거나 다른 처리를 할 수 있습니다.
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secret Diary',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.login,
      routes: AppRoutes.getRoutes(),
    );
  }
}


