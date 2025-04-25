import 'package:chapter16/component/,essage.dart';
import 'package:chapter16/component/chat_text_field.dart';
import 'package:chapter16/component/date_divider.dart';
import 'package:chapter16/component/logo.dart';
import 'package:chapter16/component/mesagge_model.dart';
import 'package:flutter/material.dart';

final sampleData = [
  MessageModel(
    id: 1,
    isMine: true,
    message: '오늘 저녁으로 먹을 만한 메뉴 추천해줘!',
    point: 1,
    date: DateTime(2024, 11, 23),
  ),
  MessageModel(
    id: 2,
    isMine: false,
    message: '칼칼한 김치찜은 어때요!?',
    point: null,
    date: DateTime(2024, 11, 23),
  ),
];

// class HomeScreen extends StatelessWidget {
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();

  // 로딩여부를 확인하는 변수
  bool isRunning = false;

  // 에러 메시지 변수
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ListView와 TextField를 세로로 정렬
      body: SafeArea(
        child: Column(
          children: [
            // ListView가 화면을 최대한으로 차지하도록 설정
            Expanded(
              child: buildMessageList(),
            ),
            ChatTextField(
              error: error,
              loading: isRunning,
              onSend: handleSendMessage,
              controller: controller
            ),
          ],
        ),
      ),
    );

    // return const Placeholder();

    // return Scaffold(
    //   body: Text('Home Screen'),
    // );
  }

  // 메시지 보내기 버튼을 누르면 실행할 함수
  handleSendMessage(){}

  Widget buildMessageList() {
    return ListView.separated(
      itemCount: sampleData.length + 1,
      itemBuilder: (context, index) => index == 0
        ? buildLogo()
        : buildMessageItem(
            message: sampleData[index - 1],
            prevMessage: index > 1 ? sampleData[index - 2] : null,
            index: index - 1,
          ),
      separatorBuilder: (_, __) => const SizedBox(height: 16.0),
    );
  }

  Widget buildLogo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: const Padding(
        padding: EdgeInsets.only(bottom: 60.0),
        child: Logo(),
      ),
    );
  }

  Widget buildMessageItem({
    MessageModel? prevMessage,
    required MessageModel message,
    required int index,
  }) {
    final isMine = message.isMine;

    // DateDivider 위젯을 그려야 하는지 판단하기
    final shouldDrawDateDivider = prevMessage == null ||
        shouldDrawDate(prevMessage.date!, message.date!);

    return Column(
      children: [
        // DateDivider 위젯을 그려야 하는지 판단하기
        if(shouldDrawDateDivider)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: DateDivider(date: message.date),
          ),

      // 정렬 위치에 따라 패딩 다르게 제공해주기
        Padding(
          padding: EdgeInsets.only(
            left: isMine ? 64.0 : 16.0,
            right: isMine ? 16.0 : 64.0
          ),
          child: Message(
            alignLeft: !isMine,
            message: message.message.trim(),
            point: message.point,
          ),
        ),
      ],
    );
  }

  // String으로 반환된 날짜가 다를 경우 true 반환
  bool shouldDrawDate(DateTime date1, DateTime date2) {
    return getStringDate(date1) != getStringDate(date2);
  }

  // DateTime을 '2024년 11우러 23일' 형태로 반환
  String getStringDate(DateTime date){
    return '${date.year}년 ${date.month}월 ${date.day}일';
  }
}
