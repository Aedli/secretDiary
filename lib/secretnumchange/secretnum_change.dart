import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecretNumChange extends StatelessWidget {
  SecretNumChange({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 화살표 뒤로가기 버튼 제거
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 회원 수정 Text
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Text(
                    '회원 수정',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // 기존 비밀번호
              Text('기존 비밀번호'),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '기존 비밀번호 입력',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),

              // 신규 비밀번호
              Text('신규 비밀번호'),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '신규 비밀번호 입력',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),

              // 비밀번호 확인
              Text('신규 비밀번호 확인'),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '신규 비밀번호 확인 입력',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),

              // 좋아하는 음식
              Text('가장 좋아하는 음식은?'),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '가장 좋아하는 음식 입력',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 40),

              // 버튼들
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.blue, // 버튼 텍스트 색 변경
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Back 버튼 클릭 시 뒤로 가기
                    },
                    child: Text('Back'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.blue, // 버튼 텍스트 색 변경
                    ),
                    onPressed: () {
                      // 수정 버튼 클릭 시 동작
                    },
                    child: Text('수정'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
