import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypage/deletefinish/deletefinish.dart';

class PasswordCheck extends StatelessWidget {
  PasswordCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Text(
                    '회원 탈퇴',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Password 확인'),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '비밀번호 입력',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),

              SizedBox(height: 40),
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
                    child: Text('돌아가기'),
                  ),
                ],
              ),
              SizedBox(height: 120,),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeleteFinish(), // 이동할 페이지
                          ),
                        );
                      },
                      child: Text(
                        '탈퇴하기',
                        style: TextStyle(
                          decoration: TextDecoration.underline, // 밑줄 추가
                          fontSize: 18, // 글자 크기 (옵션)
                          fontWeight: FontWeight.bold, // 글자 두께 (옵션)
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
