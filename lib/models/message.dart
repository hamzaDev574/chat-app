import 'dart:developer';

class Message {
  String userId;
  String docId;
  String message;
  DateTime messageTime;

  Message(
      {required this.docId,
      required this.message,
      required this.messageTime,
      required this.userId});

  factory Message.fromJson(Map map) {
    final json = Map<String, dynamic>.from(map);
    log(json.toString());

    return Message(
        docId: json['doc_id'],
        message: json['message'],
        messageTime: json['message_time'].runtimeType == DateTime
            ? json['message_time']
            : DateTime.parse(json['message_time'].toDate().toString()),
        userId: json['user_id']);
  }
}
