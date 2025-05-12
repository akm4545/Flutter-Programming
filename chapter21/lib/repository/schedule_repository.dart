import 'dart:io';

import 'package:chapter21/model/schedule_model.dart';
import 'package:dio/dio.dart';

class ScheduleRepository {
  final _dio = Dio();
  // 안드로이드에서는 10.0.2.2가 localhost에 해당함
  // final _targetUrl = 'http://${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:3000/schedule';
  final _targetUrl = 'http://${Platform.isAndroid ? '192.168.10.119' : 'localhost'}:3000/schedule';

  Future<List<ScheduleModel>> getSchedules({
    // 함수를 실행할 때 액세스 토큰을 입력받는다
    required String accessToken,
    required DateTime date,
  }) async {
    final resp = await _dio.get(
      _targetUrl,
      queryParameters: { // Query 매개변수
        'date':
            '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}',
      },
      // 요청을 보낼때 헤더에 엑세스 토큰을 포함해서 보낸다
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );

    return resp.data // 모델 인스턴스로 데이터 매핑하기
      .map<ScheduleModel>(
        (x) => ScheduleModel.fromJson(json: x),
      ).toList();
  }

  Future<String> createSchedule({
    required String accessToken,
    required ScheduleModel schedule,
  }) async {
    final json = schedule.toJson(); // JSON으로 변환

    final resp = await _dio.post(
      _targetUrl,
      data: json,
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );

    return resp.data?['id'];
  }
  
  Future<String> deleteSchedule({
    required String accessToken,
    required String id,
  }) async {
    final resp = await _dio.delete(
      _targetUrl,
      data: {
        'id': id, // 삭제할 ID 값
      },
      options: Options(
        headers:{
          'authorization': 'Bearer $accessToken',
        },
      ),
    );
    
    return resp.data?['id']; // 삭제된 ID값 반환
  }


}