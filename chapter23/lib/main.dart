import 'package:chapter23/database/drift_database.dart';
import 'package:chapter23/provider/schedule_provider.dart';
import 'package:chapter23/repository/schedule_repository.dart';
import 'package:chapter23/screen/auth_screen.dart';
import 'package:chapter23/screen/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:chapter23/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  // 플러터 프레임워크가 준비될 때까지 대기
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: '{Project URL 입력}',
    anonKey: '{API Key 입력}',
  );

  // 파이어베이스 프로젝트 설정 함수
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  await initializeDateFormatting(); //initl 패키지 초기화 (다국어화)

  // 데이터베이스 생성
  // final database = LocalDatabase();
  
  // GetIt에 데이터베이스 변수 주입하기
  // GetIt.I.registerSingleton<LocalDatabase>(database);

  // final repository = ScheduleRepository();
  // final scheduleProvider = ScheduleProvider(repository: repository);

  runApp(
    // ChangeNotifierProvider( // Provider 하위 위젯에 제공하기
    //   create: (_) => scheduleProvider,
    //   child: MaterialApp(
    //     home: HomeScreen(),
    //   ),
    // ),
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthScreen(),
      // home: HomeScreen(),
    ),
  );
}