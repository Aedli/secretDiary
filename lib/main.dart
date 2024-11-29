import 'package:flutter/material.dart';
import 'package:mypage/accountpage/account_page.dart';
import 'routes.dart'; // routes.dart 파일 import
/* todo Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
*/
import 'package:mypage/tappage/tapPage.dart';

void main() {
  runApp(const MyApp());
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


