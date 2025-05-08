import 'package:chapter21/component/custom_text_field.dart';
import 'package:chapter21/const/colors.dart';
import 'package:chapter21/model/schedule_model.dart';
import 'package:chapter21/provider/schedule_provider.dart';
import 'package:flutter/material.dart';

// material.dart 패키지의 Column 클래스와 중복되니 드리프트에서는 숨기기
import 'package:drift/drift.dart' hide Column;
import 'package:get_it/get_it.dart';
import 'package:chapter21/database/drift_database.dart';
import 'package:provider/provider.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDate; // 선택된 날짜 상위 위젯에서 입력받기

  const ScheduleBottomSheet({
    required this.selectedDate,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey(); // 폼 key 생성

  int? startTime; // 시작 시간 저장 변수
  int? endTime; // 종료 시간 저장 변수
  String? content; // 일정 내용 저장 변수

  @override
  Widget build(BuildContext context) {
    // 키보드 높이 가져오기
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    
    return Form( // 텍스트 필드를 한 번에 관리할 수 있는 폼
      key: formKey, // Form을 조작할 키값
      child: SafeArea(
        child: Container(
          // 화면 반 높이에 키보드 높이 추가하기
          height: MediaQuery.of(context).size.height / 2 + bottomInset,
          color: Colors.white,
          child: Padding(
            // padding: const EdgeInsets.only(left: 8, right: 8, top: 8),

            // 패딩에 키보드 높이 추가해서 위젯 전반적으로 위로 올리기
            padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: bottomInset),
            child: Column(
              // 시간 관련 텍스트 필드와 내용 관련 텍스트 필드 세로로 배치
              children: [
                Row(
                  // 시작 시간, 종료 시간 가로로 배치
                  children: [
                    Expanded(
                      child: CustomTextField(
                        // 시작 시간 텍스트 필드 렌더링
                        label: '시작 시간',
                        isTime: true,
                        onSaved: (String? val) {
                          // 저장이 실행되면 startTime 변수에 텍스트 필드값 저장
                          startTime = int.parse(val!);
                        },
                        validator: timeValidator,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      // 종료 시간 입력 필드
                      child: CustomTextField(
                        label: '종료 시간',
                        isTime: true,
                        onSaved: (String? val) {
                          // 저장이 실행되면 endTime 변수에 텍스트 필드값 저장
                          endTime = int.parse(val!);
                        },
                        validator: timeValidator,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Expanded(
                  child: CustomTextField( // 내용 입력 필드
                    label: '내용',
                    isTime: false,
                    onSaved: (String? val) {
                      // 저장이 실행되면 content 변수에 텍스트 필드값 저장
                      content = val;
                    },
                    validator: contentValidator,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton( // 저장 버튼
                    // onPressed: onSavePressed,
                    onPressed: () => onSavePressed(context), // 함수에 context 전달
                    style: ElevatedButton.styleFrom(
                      foregroundColor: PRIMARY_COLOR,
                    ),
                    child: Text('저장'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSavePressed(BuildContext context) async {
    if(formKey.currentState!.validate()){ // 폼 검증하기
      formKey.currentState!.save(); // 폼 저장하기

      // await GetIt.I<LocalDatabase>().createSchedule( // 일정 생성하기
      //   SchedulesCompanion(
      //     startTime: Value(startTime!),
      //     endTime: Value(endTime!),
      //     content: Value(content!),
      //     date: Value(widget.selectedDate),
      //   ),
      // );

      context.read<ScheduleProvider>().createSchedule(
        schedule: ScheduleModel(
          id: 'new_model', // 임시 ID
          content: content!,
          date: widget.selectedDate,
          startTime: startTime!,
          endTime: endTime!,
        ),
      );

      // 일정 생성 후 화면 뒤로 가기
      Navigator.of(context).pop();
      
      // print(startTime); // 시작 시간 출력
      // print(endTime); // 종료 시간 출력
      // print(content); // 내용 출력
    }
  }
  
  String? timeValidator(String? val) { // 시간값 검증
    if (val == null){
      return '값을 입력해주세요';
    }

    int? number;

    try {
      number = int.parse(val);
    }catch(e){
      return '숫자를 입력해주세요';
    }

    if(number < 0 || number > 24) {
      return '0시부터 24시 사이를 입력해주세요';
    }

    return null;
  }
  
  String? contentValidator(String? val) { // 내용값 검증
    if(val == null || val.length == 0){
      return '값을 입력해주세요';
    }

    return null;
  }
}