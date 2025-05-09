import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // @override
  // Widget build(BuildContext context) {
  //   return const Placeholder();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 깔끔한 디자인을 위해 좌, 우로 패딩을 준다
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          // 세로로 중앙 배치한다
          mainAxisAlignment: MainAxisAlignment.center,
          // 가로로 최대한의 크기로 늘려준다
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 로고를 화면 너비의 절반만큼의 크기로 렌더링하고 가운데 정렬한다
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/img/logo.png',
                width: MediaQuery.of(context).size.width * 0.5,
              ),
            ),
            const SizedBox(height: 16.0),
            // 로그인 텍스트 필드
            TextFormField(),
            const SizedBox(height: 16.0),
            // 회원가입 버튼
            ElevatedButton(
              onPressed: () {},
              child: Text('회원가입'),
            ),
            // 로그인 버튼
            ElevatedButton(
              onPressed: () async {},
              child: Text('로그인'),
            ),
          ],
        ),
      ),
    );
  }
}