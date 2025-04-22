import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

// 동영상 위젯 생성
class CustomVideoPlayer extends StatefulWidget {

  // 선택할 동영상을 저장할 변수
  // XFile은 ImagePicker로 영상 또는 이미지를 선택했을 때 반환하는 타입
  final XFile video;

  const CustomVideoPlayer({
    required this.video, // 상위에서 선택한 동영상 주입해주기
    Key? key,
  }) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  // 동영상을 조작하는 컨트롤러
  VideoPlayerController? videoController;

  @override
  void initState() {
    super.initState();

    initializeController(); // 컨트롤러 초기화
  }

  initializeController() async { // 선택한 동영상으로 컨트롤러 초기화
    final videoController = VideoPlayerController.file(
        File(widget.video.path),
    );

    await videoController.initialize();

    setState(() {
      this.videoController = videoController;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 동영상 컨트롤러가 준비 중일 때 로딩 표시
    if (videoController == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return AspectRatio( // 동영상 비율에 따른 화면 렌더링
        aspectRatio: videoController!.value.aspectRatio,
        child: Stack( // children 위젯을 위로 쌓을 수 있는 위젯
          children: [
            VideoPlayer( // VideoPlayer 위젯을 Stack으로 이동
              videoController!,
            ),
            Positioned( // child 위젯의 위치를 정할 수 있는 위젯
              bottom: 0,
              right: 0,
              left: 0,
              child: Slider( // 동영상 재생 상태를 보여주는 슬라이더
                // 슬라이더가 이동할 떄마다 실행할 함수
                onChanged: (double val){
                  videoController!.seekTo(
                    Duration(seconds: val.toInt())
                  );
                },

                // 동영상 재생 위치를 초 단위로 표현
                value: videoController!.value.position.inSeconds.toDouble(),
                // value: 0,
                min: 0,
                max: videoController!.value.duration.inSeconds.toDouble(),
              ),
            ),
          ],
        )
    );

    // return Center(
    //   child: Text(
    //     'CustomVideoPlayer', // 샘플 테스트
    //     style: TextStyle(
    //       color: Colors.white,
    //     ),
    //   ),
    // );
  }
}