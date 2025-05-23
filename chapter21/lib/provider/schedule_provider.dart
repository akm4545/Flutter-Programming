import 'package:chapter21/repository/auth_repository.dart';
import 'package:chapter21/repository/schedule_repository.dart';
import 'package:chapter21/model/schedule_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';


class ScheduleProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  final ScheduleRepository scheduleRepository; // API 요청 로직을 담은 클래스

  String? accessToken;
  String? refreshToken;

  DateTime selectedDate = DateTime.utc( // 선택한 날짜
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  Map<DateTime, List<ScheduleModel>> cache = {}; // 일정 정보를 저장해둘 변수

  ScheduleProvider({
    required this.scheduleRepository,
    required this.authRepository,
  }) : super() {
    getSchedules(date: selectedDate);
  }

  void getSchedules({
    required DateTime date,
  }) async {
    final resp = await scheduleRepository.getSchedules(
      date: date,
      // 로그인을 해야 사용자와 관련된 일정 정보를 가져오는 getSchedules() 함수를
      // 실행할 수 있는 화면으로 이동하므로 !를 붙여서 accessToken이
      // null이 아님을 명시한다
      accessToken: accessToken!,
    ); // GET 메서드 요청하기

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
      final savedSchedule = await scheduleRepository.createSchedule(
        schedule: schedule,
        accessToken: accessToken!,
      );

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
    }

    notifyListeners();
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
      await scheduleRepository.deleteSchedule(
        id: id,
        accessToken: accessToken!,
      );
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
    }
    notifyListeners();

    // final resp = await repository.deleteSchedule(id: id);
  }

  void changeSelectedDate({
    required DateTime date,
  }) {
    selectedDate = date; // 현재 선택된 날짜를 매개변수로 입력받은 날짜로 변경
    notifyListeners();
  }

  updateTokens({
    String? refreshToken,
    String? accessToken,
  }) {
    // refreshToken이 입력됐을 경우 refreshToken 업데이트
    if(refreshToken != null) {
      this.refreshToken = refreshToken;
    }

    // accessToken이 입력됐을 경우 accessToken 업데이트
    if(accessToken != null) {
      this.accessToken = accessToken;
    }

    notifyListeners();
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    // AuthRepository에 미리 구현해둔 register() 함수를 실행한다
    final resp = await authRepository.register(
      email: email,
      password: password
    );

    // 반환받은 토큰을 기반으로 토큰 프로퍼티를 업데이트한다
    updateTokens(
      refreshToken: resp.refreshToken,
      accessToken: resp.accessToken,
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final resp = await authRepository.login(
      email: email,
      password: password
    );

    updateTokens(
      refreshToken: resp.refreshToken,
      accessToken: resp.accessToken,
    );
  }

  logout() {
    // refreshToken과 accessToken을 null로 업데이트해서 로그아웃 상태로 만든다
    refreshToken = null;
    accessToken = null;

    // 로그아웃과 동시에 일정 정보 캐시도 모두 삭제된다
    cache = {};

    notifyListeners();
  }

  rotateToken({
    required String refreshToken,
    required bool isRefreshToken,
  }) async {
    // isRefreshToken이 true일 경우 refreshToken 재발급
    // false일 경우 accessToken 재발급
    if(isRefreshToken) {
      final token = await authRepository.rotateRefreshToken(refreshToken: refreshToken);

      this.refreshToken = token;
    }else{
      final token = await authRepository.rotateAccessToken(refreshToken: refreshToken);

      accessToken = token;
    }

    notifyListeners();
  }
}