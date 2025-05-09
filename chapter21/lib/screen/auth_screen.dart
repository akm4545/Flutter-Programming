import 'package:chapter21/component/login_text_field.dart';
import 'package:chapter21/const/colors.dart';
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
            // TextFormField(),
            LoginTextField(
              // 추후 회원가입/로그인 로직을 작성할 때 사용된다
              onSaved: (String? val) {}, 
              validator: (String? val) {},
              // 텍스트 필드에 어떤 값도 입력되지 않은 경우 이메일이라는
              // 힌트 텍스트를 보여준다
              hintText: '이메일',
            ),
            const SizedBox(height: 16.0),
            LoginTextField(
              // 비밀번호를 입력할 때 보안을 위해 특수문자로 가려준다
              obscureText: true,
              onSaved: (String? val) {}, 
              validator: (String? val) {},
              hintText: '비밀번호',
            ),
            // 회원가입 버튼
            ElevatedButton(
              // 버튼 배경 색상 로고 색으로 변경
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: SECONDARY_COLOR,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onPressed: () {},
              child: Text('회원가입'),
            ),
            // 로그인 버튼
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: SECONDARY_COLOR,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)
                ),
              ),
              onPressed: () async {},
              child: Text('로그인'),
            ),
          ],
        ),
      ),
    );
  }
}