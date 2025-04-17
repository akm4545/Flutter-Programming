import 'package:flutter/material.dart';

void main() {
  runApp(SplashScreen()); // SplashScreen 위젯을 첫 화면으로 지정
}

class SplashScreen extends StatelessWidget{ // StatelessWidget 선언 
  @override
  Widget build(BuildContext context) { // 위젯의 UI 구현
    return MaterialApp( // 항상 최상단에 입력되는 위젯
      home: Scaffold( // 항상 두 번째로 입력되는 위젯
        body: Container( // 컨테이너 위젯
          // 컨테이너를 디자인하는 클래스
          decoration: BoxDecoration(
            // color: Colors.orange, // 색상
            color: Color(0xFFF99231),
          ),
          // child: Center( // 중앙 정렬 위젯
          //   // 글자를 화면에 보여주는 위젯
          //   // child: Text('Splash Screen'),
          //
          //   // Text 위젯을 Image 위젯으로 변경
          //   child: Image.asset(
          //     'assets/logo.png',
          //   ),
          // ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                // 가운데 정렬 추가
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 여러 위젯을 입력할 수 있는 children 매개변수
                  Image.asset(
                    'assets/logo.png',
                    width: 200, // 너비 추가
                  ),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                      Colors.white,
                    ),
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