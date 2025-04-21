import 'package:chapter11/const/colors.dart';
import 'package:chapter11/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        sliderTheme: SliderThemeData( // Slider 위젯 관련 테마
          thumbColor: primaryColor, // 노브 색상
          activeTrackColor: primaryColor, // 노브가 이동한 트랙 색상

          // 노브가 아직 이동하지 않은 트랙 색상
          inactiveTrackColor: primaryColor.withOpacity(0.3),
        ),

        // BottomNavigationBar 위젯 관련 테마
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor, // 선택 상태 색
          unselectedItemColor: secondaryColor, // 비선택 상태 색
          backgroundColor: backgroundColor, // 배경색
        ),
      ),
      home: HomeScreen(),
    ),
  );
}