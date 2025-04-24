import 'dart:io';

import 'package:chapter15/component/main_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// class HomeScreen extends StatelessWidget {
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  XFile? image; // 선택한 이미지를 저장할 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Text('Home Screen'),
      body: Stack( // 스크린에 Body, AppBar, Footer 순서로 쌓을 준비
        fit: StackFit.expand, // 자식 위젯들 최대 크기로 펼치기
        children: [
          renderBody(),
          // MainAppBar를 좌, 우, 위 끝에 정렬
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child:MainAppBar(
              onPickImage: onPickImage,
              onSaveImage: onSaveImage,
              onDeleteItem: onDeleteItem,
            ),
          ),
        ],
      ),
    );
  }

  Widget renderBody() {
    if(image != null) {
      // Stack 크기의 최대 크기만큼 차지하기
      return Positioned.fill(
        // 위젯 확대 및 좌우 이동을 가능하게 하는 위젯
        child: InteractiveViewer(
          child: Image.file(
            File(image!.path),

            // 이미지가 부모 위젯 크기 최대를 차지하도록 하기
            fit: BoxFit.cover,
          ),
        ),
      );
    }else{
      // 이미지 선택이 안 된 경우 이미지 선택 버튼 표시
      return Center(
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey,
          ),
          onPressed: onPickImage,
          child: Text('이미지 선택하기',)
        ),
      );
    }
  }

  void onPickImage() async { 
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    
    // 갤러리에서 이미지 선택하기
    setState(() {
      this.image = image; // 선택한 이미지 저장하기
    });
  }

  void onSaveImage(){}

  void onDeleteItem(){}
}