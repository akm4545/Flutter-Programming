import 'package:chapter23/const/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDate; // 선택된 날짜
  final int count; // 일정 개수

  const TodayBanner({
    required this.selectedDate,
    required this.count,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle( // 기본으로 사용할 글꼴
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );

    return Container(
      color: PRIMARY_COLOR,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text( // "년 월 일" 형태로 표시
                '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일',
                style: textStyle,
              ),
            ),
            Text(
              '$count개', // 일정 개수 표시
              style: textStyle,
            ),
            const SizedBox(width: 8.0),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    // 구글 로그인/로그아웃
                    // await GoogleSignIn().signOut();

                    // 슈파베이스의 signOut() 함수를 실행하면 로그아웃할 수 있다
                    await Supabase.instance.client.auth.signOut();

                    // 파이어베이스 인증 로그아웃 함수
                    // await FirebaseAuth.instance.signOut();

                    // 홈 스크린으로 돌아가기
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.logout,
                    size: 16.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}