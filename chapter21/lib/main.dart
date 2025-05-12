import 'package:chapter21/database/drift_database.dart';
import 'package:chapter21/provider/schedule_provider.dart';
import 'package:chapter21/repository/auth_repository.dart';
import 'package:chapter21/repository/schedule_repository.dart';
import 'package:chapter21/screen/auth_screen.dart';
import 'package:chapter21/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

void main() async {
  // 플러터 프레임워크가 준비될 때까지 대기
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting(); //initl 패키지 초기화 (다국어화)

  // 데이터베이스 생성
  final database = LocalDatabase();
  
  // GetIt에 데이터베이스 변수 주입하기
  GetIt.I.registerSingleton<LocalDatabase>(database);

  final scheduleRepository = ScheduleRepository();
  final authRepository = AuthRepository();
  final scheduleProvider = ScheduleProvider(
    scheduleRepository: scheduleRepository,
    authRepository: authRepository,
  );

  runApp(
    ChangeNotifierProvider( // Provider 하위 위젯에 제공하기
      create: (_) => scheduleProvider,
      child: MaterialApp(
        // 초기 화면인 AuthScreen으로 변경한다
        home: AuthScreen(),
        // home: HomeScreen(),
      ),
    ),
  );
}