import 'package:chapter16/component/point_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  // true면 왼쪽 정렬 false면 오른쪽 정렬
  final bool alignLeft;
  // 보여줄 메시지
  final String message;
  // 현재까지 적립된 포인트
  final int? point;

  const Message({
    super.key,
    this.alignLeft = true,
    this.point,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    // alignLeft 기준으로 Alignment 프로퍼티 생성하기
    final alignment = alignLeft ? Alignment.centerLeft : Alignment.centerRight;

    // 왼쪽 정렬이면 더 어두운 배경 사용
    final bgColor = alignLeft ? Color(0xFFF4F4F4) : Colors.white;

    // 왼쪽 정렬일 경우 더 어두운 테두리 사용
    final border = alignLeft ? Color(0xFFE7E7E7) : Colors.black12;

    return Column(
      children: [
        // 메시지 버블 디자인 정의
        Align(
          alignment: alignment,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.0),
              color: bgColor,
              border: Border.all(
                color: border,
                width: 1
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        // point가 입력됐을 때만 PointNotification 위젯을 화면에 출력
        if(point != null)
          Align(
            alignment: alignment,
            child: PointNotification(
              point: point!,
            ),
          ),
      ],
    );
  }
}