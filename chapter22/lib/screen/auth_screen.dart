import 'package:chapter22/const/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 로고 이미지
            Center(
              child: FractionallySizedBox(
                widthFactor: 0.7,
                child: Image.asset(
                  'assets/img/logo.png'
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // 구글로 로그인 버튼
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: SECONDARY_COLOR,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)
                ),
              ),
              child: Text('구글로 로그인'),
            ),
          ],
        ),
      ),
    );
  }
}
