import 'package:chat_app/constants.dart';

class Message {
  final String message;
  final String id;
  final DateTime messageDate;
  Message(
    this.message,
    this.messageDate,
    this.id,
  );

  factory Message.fromJson(Map jsonData) {
    return Message(
      jsonData[kMessage],
      jsonData[kCreatedAt].toDate(),
      jsonData['id'],
    );
  }
}
