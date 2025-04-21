import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// class HomeScreen extends StatelessWidget {
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video; // 동영상 저장할 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Text('Home Screen'),
      backgroundColor: Colors.black,

      // 동영상이 선택됐을 때와 선택 안 됐을 때 보여줄 위젯
      body: video == null ? renderEmpty() : renderVideo(),
    );
  }

  Widget renderEmpty() { // 동영상 선택 전 보여줄 위젯
    return Container(
      width: MediaQuery.of(context).size.width, // 너비 최대로 늘려주기
      child: Column(
        // 위젯들 가운데 정렬
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(), // 로고 이미지
          SizedBox(height: 30.0),
          _AppName(), // 앱 이름
        ],
      ),
    );
  }

  Widget renderVideo() { // 동영상 선택 후 보여줄 위젯
    return Container();
  }
}

class _Logo extends StatelessWidget { // 로고를 보여줄 위젯
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'asset/img/logo.png', // 로고 이미지
    );
  }
}

class _AppName extends StatelessWidget { // 앱 제목을 보여줄 위젯
  const _AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // 글자 가운데 정렬
      children: [
        Text(
          'VIDEO',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          style: textStyle.copyWith(
            // textStyle에서 두께만 700으로 변경
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}