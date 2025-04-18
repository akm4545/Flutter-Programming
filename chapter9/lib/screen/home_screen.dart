import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// class HomeScreen extends StatelessWidget {

// StatefulWidget 정의
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// _HomeScreenState 정의
class _HomeScreenState extends State<HomeScreen>{
  // PageController 생성
  final PageController pageController = PageController();
  
  // initState() 함수 등록
  @override
  void initState() {
    super.initState(); // 부모 initState() 실행

    Timer.periodic( // Timer.periodic() 등록
        Duration(seconds: 3),
        (timer) {
          // print('실행!');
          // 현재 페이지 가져오기
          int? nextPage = pageController.page?.toInt();

          if(nextPage == null){ // 페이지 값이 없을 때 예외 처리
            return;
          }

          if(nextPage == 4){ // 첫 페이지와 마지막 페이지 분기 처리
            nextPage = 0;
          }else{
            nextPage++;
          }

          pageController.animateToPage( // 페이지 변경
              nextPage,
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
          );
        },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 상태바 색상 변경
    // 상태바가 이미 흰색이면 light 대신 dark를 주어 검정으로 바꾸자
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      // body: Text('Home Screen'),
      body: PageView( // PageView 추가
        controller: pageController, // PageController 등록
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