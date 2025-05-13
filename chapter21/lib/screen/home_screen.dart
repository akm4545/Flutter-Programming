import 'package:chapter21/component/main_calendar.dart';
import 'package:chapter21/component/schedule_bottom_sheet.dart';
import 'package:chapter21/component/schedule_card.dart';
import 'package:chapter21/component/today_banner.dart';
import 'package:chapter21/const/colors.dart';
import 'package:chapter21/database/drift_database.dart';
import 'package:chapter21/provider/schedule_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

// class HomeScreen extends StatelessWidget {
class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.utc( // 선택된 날짜를 관리할 변수
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  void initState() {
    super.initState();

    // HomeScreen 위젯이 생성되면 오늘 날짜의 일정을 바로 요청한다
    context.read<ScheduleProvider>().getSchedules(
      date: selectedDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    // 프로바이더 변경이 있을 때마다 build() 함수 재실행
    final provider = context.watch<ScheduleProvider>();

    // 선택된 날짜 가져오기
    final selectedDate = provider.selectedDate;

    // 선택된 날짜에 해당되는 일정들 가져오기
    final schedules = provider.cache[selectedDate] ?? [];

    return Scaffold(
      floatingActionButton: FloatingActionButton( // 새 일정 버튼
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          showModalBottomSheet( // BottomSheet 열기
            context: context,
            isDismissible: true, // 배경 탭했을 때 BottomSheet 닫기
            builder: (_) => ScheduleBottomSheet(
              selectedDate: selectedDate, // 선택된 날짜 넘겨주기
            ),
            // BottomSheet의 높이를 화면의 최대 높이로
            // 정의하고 스크롤 가능하게 변경
            isScrollControlled: true,
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: SafeArea( // 시스템 UI 피해서 UI 구현하기
        child: Column( // 달력과 리스트를 세로로 배치
          children: [
            // 미리 작업해둔 달력 위젯 보여주기
            MainCalendar(
              selectedDate: selectedDate, // 선택된 날짜 전달하기
              // onDaySelected: onDaySelected, // 날짜가 선택됐을 때 실행할 함수
              onDaySelected: (selectedDate, focusedDate) =>
                onDaySelected(selectedDate, focusedDate, context),
            ),
            SizedBox(height: 8.0),
            // build() 함수 내부의 TodayBanner 위젯
            TodayBanner(
              selectedDate: selectedDate,
              count: schedules.length,
            ),
            // StreamBuilder<List<Schedule>>( // 일정 Stream으로 받아오기
            //   stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
            //   builder: (context, snapshot) {
            //     return TodayBanner(
            //       selectedDate: selectedDate,
            //       count: snapshot.data?.length ?? 0, // 일정 개수 입력해주기
            //     );
            //   }
            // ),
            SizedBox(height: 8.0),
            Expanded( // 남는 공간을 모두 차지하기
              // 일정 정보가 Stream으로 제공되기 때문에 StreamBuilder 사용
              child: ListView.builder(
                // 리스트에 입력할 값들의 총 개수
                // itemCount: snapshot.data!.length,
                itemCount: schedules.length,
                itemBuilder: (context, index) {
                  // 현재 index에 해당되는 일정
                  // final schedule = snapshot.data![index];
                  final schedule = schedules[index];

                  return Dismissible(
                    key: ObjectKey(schedule.id), // 유니크한 키값
                    // 밀기 방향 (왼쪽에서 오른쪽으로)
                    direction: DismissDirection.startToEnd,
                    // 밀기 했을 때 실행할 함수
                    onDismissed: (DismissDirection direction){
                      // GetIt.I<LocalDatabase>()
                      //     .removeSchedule(schedule.id);
                      provider.deleteSchedule(date: selectedDate, id: schedule.id);
                    },
                    child: Padding( // 좌우로 패딩을 추가해서 UI 개선
                      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                      child: ScheduleCard(
                        startTime: schedule.startTime,
                        endTime: schedule.endTime,
                        content: schedule.content,
                      ),
                    ),
                  );
                },
              ),

              // StreamBuilder<List<Schedule>>(
              //   stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
              //   builder: (context, snapshot){
              //     if(!snapshot.hasData){ // 데이터가 없을 때
              //       return Container();
              //     }
              //
              //     // 화면에 보이는 값들만 렌더링하는 리스트
              //     return ListView.builder(
              //       // 리스트에 입력할 값들의 총 개수
              //       itemCount: snapshot.data!.length,
              //       itemBuilder: (context, index) {
              //         // 현재 index에 해당되는 일정
              //         final schedule = snapshot.data![index];
              //
              //         return Dismissible(
              //           key: ObjectKey(schedule.id), // 유니크한 키값
              //           // 밀기 방향 (왼쪽에서 오른쪽으로)
              //           direction: DismissDirection.startToEnd,
              //           // 밀기 했을 때 실행할 함수
              //           onDismissed: (DismissDirection direction){
              //             GetIt.I<LocalDatabase>()
              //                 .removeSchedule(schedule.id);
              //           },
              //           child: Padding( // 좌우로 패딩을 추가해서 UI 개선
              //             padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
              //             child: ScheduleCard(
              //               startTime: schedule.startTime,
              //               endTime: schedule.endTime,
              //               content: schedule.content,
              //             ),
              //           ),
              //         );
              //       },
              //     );
              //   },
              // ),
            ),
            // ScheduleCard( // 구현해둔 일정 카드
            //   startTime: 12,
            //   endTime: 14,
            //   content: '프로그래밍 공부',
            // ),
          ],
        ),
      ),
      // body: Text('Home Screen'),
    );
  }

  void onDaySelected(
    DateTime selectedDate, 
    DateTime focusedDate,
    BuildContext context,
  ){
    // 날짜 선택될 때마다 실행할 함수
    // setState(() {
    //   this.selectedDate = selectedDate;
    // });
    final provider = context.read<ScheduleProvider>();
    provider.changeSelectedDate(
      date: selectedDate,
    );
    provider.getSchedules(date: selectedDate);
  }
}