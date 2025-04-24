import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget{
  // 직접 너비를 정의할 경우를 대비한 너비 파라미터
  final double width;
  // 직접 높이를 정의할 경우를 대비한 높이 파라미터
  final double height;

  const Logo({
    super.key,
    this.width = 200,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset( // 로고 이미지
          'asset/img/logo.png',
          width: width,
          height: height,
        ),
        SizedBox(height: 32.0),
        Text( // 앱 설명 텍스트
          '안녕! 나는 너의 친구 소울챗이야!\n나와 대화를 하며 친밀도를 높여보자!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}