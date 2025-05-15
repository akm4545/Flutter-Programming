import 'package:chapter24/component/banner_ad_widget.dart';
import 'package:chapter24/component/main_calendar.dart';
import 'package:chapter24/component/schedule_bottom_sheet.dart';
import 'package:chapter24/component/schedule_card.dart';
import 'package:chapter24/component/today_banner.dart';
import 'package:chapter24/const/colors.dart';
import 'package:chapter24/database/drift_database.dart';
import 'package:chapter24/model/schedule_model.dart';
import 'package:chapter24/provider/schedule_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

// class HomeScreen extends StatelessWidget {
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
  Widget build(BuildContext context) {
    // provider 관련 코드 삭제
    // 프로바이더 변경이 있을 때마다 build() 함수 재실행
    // final provider = context.watch<ScheduleProvider>();

    // 선택된 날짜 가져오기
    // final selectedDate = provider.selectedDate;

    // 선택된 날짜에 해당되는 일정들 가져오기
    // final schedules = provider.cache[selectedDate] ?? [];

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
            StreamBuilder<QuerySnapshot>(
              // ListView에 적용했던 같은 쿼리
              stream: FirebaseFirestore.instance
                .collection(
                  'schedule'
                )
                .where(
                  'date',
                  isEqualTo: '${selectedDate.year}${selectedDate.month.toString().padLeft(2, '0')}${selectedDate.day.toString().padLeft(2, '0')}',
                )
                .where(
                  'author',
                  isEqualTo: FirebaseAuth.instance.currentUser!.email
                )
                .snapshots(),
              builder: (context, snapshot) {
                return TodayBanner(
                  selectedDate: selectedDate,
                  // 개수 가져오기
                  count: snapshot.data?.docs.length ?? 0,
                );
              }
            ),
            // TodayBanner(
            //   selectedDate: selectedDate,
            //   count: schedules.length,
            // ),
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
              // StreamBuilder 구현하기
              child: StreamBuilder<QuerySnapshot>(
                // 파이어스토어로부터 일정 정보 받아오기
                stream: FirebaseFirestore.instance
                  .collection(
                    'schedule',
                  )
                  .where(
                    'date',
                    isEqualTo:
                      '${selectedDate.year}${selectedDate.month.toString().padLeft(2, '0')}${selectedDate.day.toString().padLeft(2, '0')}',
                  )
                  .where(
                    'author',
                    isEqualTo: FirebaseAuth.instance.currentUser!.email
                  )
                  .snapshots(),
                builder: (context, snapshot) {
                  // Stream을 가져오는 동안 에러가 났을 때 보여줄 화면
                  if(snapshot.hasError) {
                    return Center(
                      child: Text('일정 정보를 가져오지 못했습니다.'),
                    );
                  }

                  // 로딩 중일 때 보여줄 화면
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Container();
                  }

                  // ScheduleModel로 데이터 매핑하기
                  final schedules = snapshot.data!.docs
                    .map(
                      (QueryDocumentSnapshot e) => ScheduleModel.fromJson(
                        // 데이터를 불러와서 map 변환
                        json: (e.data() as Map<String, dynamic>),
                      )
                    )
                    .toList();


                  // return ListView.builder(
                  // ListView.separated로 변경
                  return ListView.separated(
                    itemCount: schedules.length,

                    // 일정 중간중간에 실행될 함수
                    separatorBuilder: (context, index) {
                      return BannerAdWidget();
                    },
                    itemBuilder: (context, index) {
                      final schedule = schedules[index];

                      return Dismissible(
                        key: ObjectKey(schedule.id),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (DismissDirection direction){
                          // 특정 문서 삭제하기
                          FirebaseFirestore.instance
                            .collection('schedule')
                            .doc(schedule.id)
                            .delete();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8.0, left: 8.0, right: 8.0,
                          ),
                          child: ScheduleCard(
                            startTime: schedule.startTime,
                            endTime: schedule.endTime,
                            content: schedule.content,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),

              // child: ListView.builder(
              //   // 리스트에 입력할 값들의 총 개수
              //   // itemCount: snapshot.data!.length,
              //   itemCount: schedules.length,
              //   itemBuilder: (context, index) {
              //     // 현재 index에 해당되는 일정
              //     // final schedule = snapshot.data![index];
              //     final schedule = schedules[index];
              //
              //     return Dismissible(
              //       key: ObjectKey(schedule.id), // 유니크한 키값
              //       // 밀기 방향 (왼쪽에서 오른쪽으로)
              //       direction: DismissDirection.startToEnd,
              //       // 밀기 했을 때 실행할 함수
              //       onDismissed: (DismissDirection direction){
              //         // GetIt.I<LocalDatabase>()
              //         //     .removeSchedule(schedule.id);
              //         provider.deleteSchedule(date: selectedDate, id: schedule.id);
              //       },
              //       child: Padding( // 좌우로 패딩을 추가해서 UI 개선
              //         padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
              //         child: ScheduleCard(
              //           startTime: schedule.startTime,
              //           endTime: schedule.endTime,
              //           content: schedule.content,
              //         ),
              //       ),
              //     );
              //   },
              // ),

              // 일정 정보가 Stream으로 제공되기 때문에 StreamBuilder 사용
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
    setState(() {
      this.selectedDate = selectedDate;
    });
    
    // provider 관련 코드 삭제
    // final provider = context.read<ScheduleProvider>();
    // provider.changeSelectedDate(
    //   date: selectedDate,
    // );
    // provider.getSchedules(date: selectedDate);
  }
}