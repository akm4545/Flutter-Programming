import 'package:chapter18/model/schedule.dart';
import 'package:drift/drift.dart';

// private값까지 불러올 수 있음
part 'drift_database.g.dart';  // part 파일 지정

@DriftDatabase( // 사용할 테이블 등록
  tables: [
    Schedules,
  ],
)
class LocalDatabase extends _$LocalDatabase{}
// Code Generation으로 생성할 클래스 상속
