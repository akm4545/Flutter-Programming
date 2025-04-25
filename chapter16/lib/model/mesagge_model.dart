import 'package:isar/isar.dart';
part 'mesagge_model.g.dart';

@collection
class MessageModel {
  // Message ID
  Id id = Isar.autoIncrement;

  // true : 내가 보낸 메시지 / false : AI가 보낸 메시지
  bool isMine;

  // 메시지 내용
  String message;

  // 포인트 (AI 메시지의 경우 null)
  int? point;

  // 메시지 전송 날짜
  DateTime date;

  MessageModel({
    required this.isMine,
    required this.message,
    required this.date,
    this.id = Isar.autoIncrement,
    this.point
  });
}
