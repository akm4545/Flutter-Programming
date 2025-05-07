import 'package:chapter20/repository/schedule_repository.dart';
import 'package:chapter20/model/schedule_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';


class ScheduleProvider extends ChangeNotifier {
  final ScheduleRepository repository; // API 요청 로직을 담은 클래스

  DateTime selectedDate = DateTime.utc( // 선택한 날짜
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  Map<DateTime, List<ScheduleModel>> cache = {}; // 일정 정보를 저장해둘 변수

  ScheduleProvider({
    required this.repository,
  }) : super() {
    getSchedules(date: selectedDate);
  }

  void getSchedules({
    required DateTime date,
  }) async {
    final resp = await repository.getSchedules(date: date); // GET 메서드 요청하기

    // 선택한 날짜와 일정들 업데이트하기
    cache.update(date, (value) => resp, ifAbsent: () => resp);

    // 리슨하는 위젯들 업데이트하기
    notifyListeners();
  }

  void createSchedule({
    required ScheduleModel schedule,
  }) async {
    final targetDate = schedule.date;

    final uuid = Uuid();

    final tempId = uuid.v4(); // 유일한 ID값 생성
    final newSchedule = schedule.copyWith(
      id: tempId, // 임시 ID를 지정
    );

    // 긍정적 응답 구간. 서버에서 응답을 받기 전에 캐시를 먼저 업데이트한다
    cache.update(
      targetDate,
          (value) => [ // 현존하는 캐시 리스트 끝에 새로운 일정 추가
        ...value,
        // schedule.copyWith(
        //   id: savedSchedule, // ID 값은 저장해야 생성되니 입력한 객체 복사 후 추가
        // ),
        newSchedule,    
      ]..sort(
            (a, b) =>
            a.startTime.compareTo(
              b.startTime,
            ),
      ),
      // 날짜에 해당되는 값이 없다면 새로운 리스트에 새로운 일정 하나만 추가
      ifAbsent: () => [newSchedule],
    );

    // 캐시 업데이트 반영
    notifyListeners();

    try{
      // API 요청을 한다
      final savedSchedule = await repository.createSchedule(schedule: schedule);

      // 서버 응답 기반으로 캐시 업데이트
      cache.update(
        targetDate,
        (value) => value
            .map((e) => e.id == tempId
              ? e.copyWith(
                id: savedSchedule,
              )
            : e)
            .toList(),
      );
    }catch(e){
      // 생성 실패 시 캐시 롤백
      cache.update(
        targetDate,
        (value) => value.where((e) => e.id != tempId).toList(),
      );

      notifyListeners();
    }
  }

  void deleteSchedule({
    required DateTime date,
    required String id,
  }) async {
    // 삭제할 일정 기억
    final targetSchedule = cache[date]!.firstWhere(
          (e) => e.id == id,
    );

    // 긍정적 응답 (응답 전에 캐시 먼저 업데이트)
    cache.update( // 캐시에서 데이터 삭제
      date,
          (value) => value.where((e) => e.id != id).toList(),
      ifAbsent: () => [],
    );

    // 캐시 업데이트 반영하기
    notifyListeners();

    try{
      // 삭제 함수 실행
      await repository.deleteSchedule(id: id);
    }catch(e){
      // 삭제 실패 시 캐시 롤백하기
      cache.update(
        date,
        (value) => [...value, targetSchedule]..sort(
          (a, b) => a.startTime.compareTo(
            b.startTime,
          ),
        ),
      );

      notifyListeners();
    }

    // final resp = await repository.deleteSchedule(id: id);
  }

  void changeSelectedDate({
    required DateTime date,
  }) {
    selectedDate = date; // 현재 선택된 날짜를 매개변수로 입력받은 날짜로 변경
    notifyListeners();
  }
}