import 'package:etc/model/student.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // 하이브 초기화
  await Hive.initFlutter();

  // 어댑터 등록하기
  Hive.registerAdapter<Student>(StudentAdapter());

  // 박스 열기
  final box = await Hive.openBox<String>('student_name');

  // 박스에 값을 추가한다
  box.add('코드팩토리');

  // 박스 내부의 값들을 Map 형태로 출력한다
  print(box.toMap());

  // 임시로 플러터앱 실행
  runApp(
    MaterialApp(
      home: Scaffold(),
    ),
  );
}