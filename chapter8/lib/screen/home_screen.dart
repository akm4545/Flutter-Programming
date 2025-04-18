import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  // HomeScreen 클래스의 생성자(HomeScreen({Key? key}))가 호출됨 → 위젯 인스턴스가 만들어짐
  // Flutter 프레임워크가 화면에 이 위젯을 렌더링하려고 할 때 build(BuildContext context) 메서드를 호출함
  // build() 내부에서 UI 요소를 반환하면 그게 화면에 표시됨
  // const 생성자
  const HomeScreen({Key? key}) : super(key: key);

  // Key -> 리액트의 컴포넌트 key 개념

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Home Screen'),
    );
  }   
}