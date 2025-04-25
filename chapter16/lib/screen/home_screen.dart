import 'package:chapter16/component/message.dart';
import 'package:chapter16/component/chat_text_field.dart';
import 'package:chapter16/component/date_divider.dart';
import 'package:chapter16/component/logo.dart';
import 'package:chapter16/model/mesagge_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

final sampleData = [
  // MessageModel(
  //   id: 1,
  //   isMine: true,
  //   message: '오늘 저녁으로 먹을 만한 메뉴 추천해줘!',
  //   point: 1,
  //   date: DateTime(2024, 11, 23),
  // ),
  // MessageModel(
  //   id: 2,
  //   isMine: false,
  //   message: '칼칼한 김치찜은 어때요!?',
  //   point: null,
  //   date: DateTime(2024, 11, 23),
  // ),
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
      backgroundColor: Colors.white,
      // ListView와 TextField를 세로로 정렬
      body: SafeArea(
        child: Column(
          children: [
            // ListView가 화면을 최대한으로 차지하도록 설정
            Expanded(
              // MessageModel 컬렉션에 업데이트가 있을 때마다 ListView를
              // 다시 그려야 하니 StreamBuilder를 사용한다

              child: StreamBuilder<List<MessageModel>>(
                // Isar 쿼리로부터 Stream을 불러온다
                stream: GetIt.I<Isar>().messageModels.where()
                  .watch(fireImmediately: true),
                builder: (context, snapshot) {
                  final messages = snapshot.data ?? [];
                  return buildMessageList();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
              child: ChatTextField(
                  error: error,
                  loading: isRunning,
                  onSend: handleSendMessage,
                  controller: controller
              ),
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
  handleSendMessage() async {
    // TextField에 입력된 메시지가 없으면 에러 보여주기
    if(controller.text.isEmpty) {
      setState(() => error = '메시지를 입력해주세요!');
      return;
    }

    // 현재 응답받고 있는 메시지 ID (스트림으로 지속적으로 업데이트하기)
    int? currentModelMessageId;

    // 내가 보낸 메시지에 배정된 ID (에러가 발생하면 삭제하기)
    int? currentUserMessageId;

    // Isar 인스턴스 가져오기
    final isar = GetIt.I<Isar>();

    // TextField에 입력된 값 가져오기
    final currentPrompt = controller.text;

    try {
      // 로딩 중으로 상태 변경
      setState(() {
        isRunning = true;
      });

      // TextField에 입력된 값 모두 삭제
      controller.clear();

      // 현재 데이터베이스에 저장되어 있는 내가 보낸 메시지 숫자 세기(포인트용)
      final myMessagesCount = await isar.messageModels.filter()
        .isMineEqualTo(true).count();

      // 내가 보낸 메시지 Isar에 저장하기
      currentUserMessageId = await isar.writeTxn(() async {
        return await isar.messageModels.put(
          MessageModel(
            isMine: true,
            message: currentPrompt,
            point: myMessagesCount + 1,
            date: DateTime.now(),
          ),
        );
      });

      // 최근 5개의 메시지만 불러온다
      final contextMessages = await isar.messageModels.where().limit(5).findAll();

      // 최근 메시지를 Content로 반환한다.
      final List<Content> promptContext = contextMessages.map(
          (e) => Content(
            // 사용자가 보낸 메시지는 'user', 제미나이가 대답한 메시지는 'model' Role을 지정해주면 된다
            e.isMine! ? 'user' : 'model',
            [
              // 문자 메시지를 제공하려면 TextPart 클래스를 사용한다
              TextPart(e.message!),
            ],
          ),
      ).toList();

      final model = GenerativeModel(
        // 사용하려는 모델을 정의할 수 있다
        model: 'gemini-1.5-flash',
        apiKey: '발급받은 키 입력',

        // 제미나이와 통신하기에 앞서 제미나이가 어떤 역할을 해야 하는지 정의할 수 있다
        systemInstruction:
          Content.system('너는 이제부터 착하고 친절한 친구의 역할을 할 거야. 앞으로 채팅을 하면서 긍정적인 말만 할 수 있도록 해줘.'),
      );

      // Stream으로 받아지는 메시지를 지속적으로 추가할 문자열
      String message = '';

      // generateContentStream을 실행하면 Stream으로 응답을 받을 수 있다
      model.generateContentStream(promptContext).listen(
          (event) async {
            // 응답 메시지가 있다면 message 변수에 추가한다.
            if(event.text != null){
              message += event.text!;
            }

            // message 변수를 기반으로 MessageModel을 생성한다
            final MessageModel model = MessageModel(
              isMine: false,
              message: message,
              date: DateTime.now(),
            );

            // 이미 메시지를 생성한적이 있다면 model 변수에 id 프로퍼티를 추가한다
            if(currentModelMessageId != null){
              model.id = currentModelMessageId!;
            }

            // 메시지를 저장하고 반환받은 ID값을 currentModelMessageId에 할당한다
            currentModelMessageId = await isar.writeTxn<int>(() => isar
              .messageModels.put(model)
            );
          },

          // Stream이 끝나면 로딩 상태를 변경한다
          onDone: () => setState(() {
            isRunning = false;
          }),

          // 에러가 발생하면 생성했던 내 메시지를 삭제하고 에러 및 로딩 상태를 업데이트한다
          onError: (e) async {
            await isar.writeTxn(() async {
              return isar.messageModels.delete(currentUserMessageId!);
            });

            setState(() {
              error = e.toString();
              isRunning = false;
            });
          },
      );
    }catch(e){
      // 에러가 있을 경우 SnackBar로 에러 메시지 표시해주기
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // 더는 샘플 데이터를 사용하지 않고 실제 데이터를 사용한다
  Widget buildMessageList(List<MessageModel> messages) {
    return ListView.separated(
      itemCount: messages.length + 1,
      itemBuilder: (context, index) => index == 0
        ? buildLogo()
        : buildMessageItem(
            message: messages[index - 1],
            prevMessage: index > 1 ? messages[index - 2] : null,
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
