// 머티리얼 디자인과 관련된 기능을 불러오는 코드
// material.dart 파일을 불러와야
// 플러터에서 기본 제공해주는 위젯들을 사용할 수 있다
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp( // 머티리얼 디자인 위젯
      home: Scaffold( // Scaffold 위젯
        body: Center(
            child: Text( // Text 위젯
              'Hello Code Factory', // 마지막 매개변수에 끝에 콤마 추가
            ),
        ),
      ),
    ),
  );
}