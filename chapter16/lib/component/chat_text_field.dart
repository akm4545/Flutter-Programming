import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatTextField extends StatelessWidget {
  // 입력값 추출을 위해 외부에서 controller 직접 입력받기
  final TextEditingController controller;
  // 전송 버튼을 눌렀을 때 실행할 함수 입력받기
  final VoidCallback onSend;
  // 에러 메시지 있을 경우 입력받기
  final String? error;
  // 로딩 중일 경우 전송 버튼 디자인 회색으로 변경 및 비활성화하기
  final bool loading;

  const ChatTextField({
    super.key,
    this.error,
    this.loading = false,
    required this.onSend,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,

      // 커서 파란색으로 변경
      cursorColor: Colors.blueAccent,

      // 텍스트 필드 세로 중앙 정렬
      textAlignVertical: TextAlignVertical.center,

      // 입력필드 최소 1줄
      minLines: 1,

      // 입력필드 최대 4줄
      maxLength: 4,
      decoration: InputDecoration(
        errorText: error,

        // 텍스트 필드 전송 버튼
        suffixIcon: IconButton(
          onPressed: loading ? null : onSend,
          icon: Icon(
            Icons.send_outlined,
            color: loading ? Colors.grey : Colors.blueAccent,
          ),
        ),

        // 테두리 둥근 형태로 변경하기
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),

        // 텍스트 필드 선택되어 있는 경우 파란색으로 테두리 변경하기
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(
            color: Colors.blueAccent,
            width: 2.0,
          ),
        ),
        hintText: '메시지를 입력해주세요!',
      ),
    );
  }
}