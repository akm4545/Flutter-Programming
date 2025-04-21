import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class RootScreen extends StatelessWidget {
class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with
TickerProviderStateMixin{ // TickerProviderStateMixin 사용하기
  TabController? controller; // 사용할 TabController 선언

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 2, vsync: this); // 컨트롤러 초기화하기

    // 컨트롤러 속성이 변경될 때마다 실행할 함수 등록
    // ! -> nullable 타입일 가능성을 해당 시점에선 절대 null이 아님을 알려주는 연산자
    controller!.addListener(tabListener);
  }

  // 리스너로 사용할 함수
  tabListener() {
    setState(() {

    });
  }

  @override
  void dispose() {
    controller!.removeListener(tabListener); // 리스너에 등록한 함수 등록 취소
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView( // 탭 화면을 보여줄 위젯
          controller: controller, // 컨트롤러 등록하기
          children: renderChildren(),
      ),

      // 아래 탭 내비게이션을 구현하는 매개변수
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  List<Widget> renderChildren() {
    return [
      Container( // 홈 탭
        child: Center(
          child: Text(
            'Tab 1',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      Container( // 설정 스크린 탭
        child: Center(
          child: Text(
            'Tab 2',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    ];
  }

  BottomNavigationBar renderBottomNavigation() {
    // 탭 내이게이션을 구현하는 위젯
    return BottomNavigationBar(
      // 현재 화면에 렌더링되는 탭의 인덱스
      currentIndex: controller!.index,
      onTap: (int index){ // 탭이 선택될 때마다 실행되는 함수
        setState(() {
          controller!.animateTo(index);
        });
      },
      items: [
        BottomNavigationBarItem( // 하단 탭바의 각 버튼을 구현
            icon: Icon(
              Icons.edgesensor_high_outlined,
            ),
            label: '주사위',
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: '설정',
        ),
    ]);
  }
}