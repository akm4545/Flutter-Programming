import 'package:isar/isar.dart';
part 'mesagge_model.g.dart';

@collection
class MessageModel {
  // Message ID
  final Id id;

  // true : 내가 보낸 메시지 / false : AI가 보낸 메시지
  final bool isMine;

  // 메시지 내용
  final String message;

  // 포인트 (AI 메시지의 경우 null)
  final int? point;

  // 메시지 전송 날짜
  final DateTime date;

  MessageModel({
    required this.id,
    required this.isMine,
    required this.message,
    required this.date,
    this.point
  });
}
