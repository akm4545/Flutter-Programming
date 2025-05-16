import 'package:hive_flutter/hive_flutter.dart';

// 코드 생성으로 생성될 파일 이름 추가하기
part 'student.g.dart';

// 각 클래스 타입별로 typeID 지정 필요
@HiveType(typeId: 1)
class Student {
  // 하이브에 저장할 필드들에 유일한 ID값 지정
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int age;

  Student({
    required this.name,
    required this.age,
  });

  @override
  String toString() {
    return 'Student(name: $name, age: $age)';
  }
}