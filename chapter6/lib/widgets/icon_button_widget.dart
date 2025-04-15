import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconButtonWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: IconButton(
              onPressed: () {},
              icon: Icon(
                // 플러터에서 기본으로 제공하는 아이콘
                // 제공되는 아이콘 목록은 다음 링크에서 확인할 수 있다
                // https://fonts.google.com/icons
                Icons.home,
              ),
          ),
        ),
      ),
    );
  }
}