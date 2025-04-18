import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 상태바 색상 변경
    // 상태바가 이미 흰색이면 light 대신 dark를 주어 검정으로 바꾸자
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      // body: Text('Home Screen'),
      body: PageView( // PageView 추가
        children: [1, 2, 3, 4, 5] //샘플 리스트 생성
        .map( // 위젯으로 매핑
            (number) => Image.asset(
                'asset/img/image_$number.jpeg',
                fit: BoxFit.cover, // BoxFit.cover 설정
            ),
        ).toList(),
      ),
    );
  }
}