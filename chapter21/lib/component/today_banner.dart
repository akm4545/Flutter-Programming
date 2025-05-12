import 'package:chapter21/const/colors.dart';
import 'package:chapter21/provider/schedule_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDate; // 선택된 날짜
  final int count; // 일정 개수

  const TodayBanner({
    required this.selectedDate,
    required this.count,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ScheduleProvider>();

    final textStyle = TextStyle( // 기본으로 사용할 글꼴
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );

    return Container(
      color: PRIMARY_COLOR,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text( // "년 월 일" 형태로 표시
              '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일',
              style: textStyle,
            ),
            Row(
              children: [
                Text(
                  '$count개', // 일정 개수 표시
                  style: textStyle,
                ),
                const SizedBox(width: 8.0,),
                // 아이콘을 눌렀을 때 로그아웃 진행
                GestureDetector(
                  onTap: () {
                    provider.logout();

                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 16.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}