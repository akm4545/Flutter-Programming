import 'dart:io';

import 'package:chapter15/component/emoticon_sticker.dart';
import 'package:chapter15/component/footer.dart';
import 'package:chapter15/component/main_app_bar.dart';
import 'package:chapter15/model/sticker_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

// class HomeScreen extends StatelessWidget {
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  XFile? image; // 선택한 이미지를 저장할 변수
  Set<StickerModel> stickers = {}; // 화면에 추가된 스티커를 저장할 변수
  String? selectedId; // 현재 선택된 스티커의 ID

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
          // image가 선택되면 Footer 위치하기
          if(image != null)
            Positioned( // 맨 아래에 Footer 윚세 위치하기
              bottom: 0,
              // left와 right를 모두 0을 주면 좌우로 최대 크기를 차지함
              left: 0,
              right: 0,
              child: Footer(
                onEmotionTap: onEmotionTap
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
          child: Stack(
            fit: StackFit.expand, // 크기 최대로 늘려주기
            children: [
              Image.file(
                File(image!.path),
                fit: BoxFit.cover, // 이미지 최대한 공간 차지하게 하기
              ),
              ...stickers.map(
                (sticker) => Center( // 최초 스티커 선택 시 중앙에 배치
                  child: EmoticonSticker(
                    key: ObjectKey(sticker.id),
                    onTransform: () {
                      // 스티커의 ID값 함수의 매개변수로 전달
                      onTransform(sticker.id);
                    },
                    imgPath: sticker.imgPath,
                    isSelected: selectedId == sticker.id,
                  ),
                ),
              ),
            ],
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

  void onTransform(String id) {
    // 스티커가 변형될 때마다 변형 중인
    // 스티커를 현재 선택한 스티커로 지정
    setState(() {
      selectedId = id;
    });
  }

  void onEmotionTap(int index) async {
    setState(() {
      stickers = {
        ...stickers,
        StickerModel(
          id: Uuid().v4(), // 스티커의 고유 ID
          imgPath: 'asset/img/emoticon_$index.png',
        ),
      };
    });
  }

  void onPickImage() async { 
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    
    // 갤러리에서 이미지 선택하기
    setState(() {
      this.image = image; // 선택한 이미지 저장하기
    });
  }

  void onSaveImage(){}

  void onDeleteItem() async {
    setState(() {
      // 현재 선택돼 있는 스티커를 제외해서 Set으로 변환
      stickers = stickers.where((sticker) => sticker.id != selectedId).toSet();
    });
  }
}