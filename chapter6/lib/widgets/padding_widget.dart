import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaddingWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            color: Colors.blue,
            child: Padding(
                // 상하, 좌우로 모두 16픽셀만큼 패딩을 적용한다
                padding: EdgeInsets.all(
                    16.0,
                ),
                child: Container(
                  color: Colors.red,
                  width: 50.0,
                  height: 50.0,
                ),
            ),
          ),
        ),
      ),
    );
  }
}

class MarginWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          // 최상위 검정 컨테이너 (margin이 적용되는 대상)
          child: Container(
            color: Colors.black,

            // 중간 파란 컨테이너
            child: Container(
              color: Colors.blue,

              // 마진 적용 위치
              margin: EdgeInsets.all(16.0),

              // 패딩 적용
              child: Padding(
                  padding: EdgeInsets.all(16.0),
                  // 패딩이 적용된 빨간 컨테이너
                  child: Container(
                    color: Colors.red,
                    width: 50,
                    height: 50,
                  ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}