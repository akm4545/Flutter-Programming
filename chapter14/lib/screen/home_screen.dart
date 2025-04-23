import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatelessWidget {
  static final LatLng companyLatLng = LatLng( // 지도 초기화 위치
      37.5233273, // 위도
      126.921252, // 경도
  );

  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold( // 지도 위치 지정
      appBar: renderAppBar(),
      body: Column(
        children: [
          Expanded( // 2/3만큼 공간 차지
            flex: 2,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: companyLatLng,
                zoom: 16, // 확대 정도 (높을수록 크게 보임)
              ),
            ),
          ),
          Expanded( // 1/3 만큼 공간 차지
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon( // 시계 아이콘
                  Icons.timelapse_outlined,
                  color: Colors.blue,
                  size: 50.0,
                ),
                const SizedBox(height: 20.0),
                ElevatedButton( // [출근하기] 버튼
                    onPressed: () {},
                    child: Text('출근하기!'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar renderAppBar() {
    // AppBar를 구현하는 함수
    return AppBar(
      centerTitle: true,
      title: Text(
        '오늘도 출첵',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}