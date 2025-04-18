import 'package:flutter/material.dart';

// 웹뷰 플러그인 불러오기
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {

  // WebViewController 선언
  WebViewController webViewController = WebViewController()
    // WebViewController의 loadRequest() 함수를 실행
    // ..으로 메서드 연결하여 실행 -> 즉 반환된 인스턴스에 바로 메서드 실행
    ..loadRequest(Uri.parse('https://blog.codefactory.ai'))
    // Javascript가 제한 없이 실행될 수 있도록 한다
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  // HomeScreen 클래스의 생성자(HomeScreen({Key? key}))가 호출됨 → 위젯 인스턴스가 만들어짐
  // Flutter 프레임워크가 화면에 이 위젯을 렌더링하려고 할 때 build(BuildContext context) 메서드를 호출함
  // build() 내부에서 UI 요소를 반환하면 그게 화면에 표시됨
  // const 생성자
  // const HomeScreen({Key? key}) : super(key: key);

  HomeScreen({Key? key}) : super(key: key);

  // Key -> 리액트의 컴포넌트 key 개념

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 앱바 위젯 추가
      appBar: AppBar(
        // 배경색 지정
        backgroundColor: Colors.orange,

        // 앱 타이틀 설정
        title: Text('Code Factory'),

        // 가운데 정렬
        centerTitle: true,
      ),
      // body: Text('Home Screen'),
      body: WebViewWidget( // 웹뷰 위젯 추가하기 (에러 잠시 무시하기)
          controller: webViewController, //에러 발생
      ),
    );
  }   
}