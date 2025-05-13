import 'package:chapter22/const/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
              // 나중에 BuildContext가 필요하기 때문에 전달해준다
              onPressed: () => onGoogleLoginPress(context),
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

  onGoogleLoginPress(BuildContext context) async {
    // 구글 로그인 객체를 생성
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    try{
      // signIn 함수를 실행해서 로그인을 진행한다
      GoogleSignInAccount? account = await googleSignIn.signIn();

      // 어떤 값을 반환받는지 출력하여 확인한다
      print(account);
    }catch(error){
      print("==============================");
      print("==============================");
      print("==============================");
      print("==============================");
      print("==============================");
      print(error);
      // 로그인 에러가 나면 Snackbar를 보여준다
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 실패')),
      );
    }
  }
}
