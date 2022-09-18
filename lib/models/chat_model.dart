class ChatModel {
  String chatId;
  bool isRead;
  String lastMessage;
  DateTime lastMessageTime;
  int numberOfUnreadMessages;
  String recieverName;

  ChatModel(
      {required this.chatId,
      required this.isRead,
      required this.lastMessage,
      required this.lastMessageTime,
      required this.numberOfUnreadMessages,
      required this.recieverName});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
        chatId: json['chat_id'],
        isRead: json['is_read'],
        lastMessage: json['last_message'],
        lastMessageTime:
            DateTime.parse(json['last_message_time'].toDate().toString()),
        numberOfUnreadMessages: json['number_of_unread_messages'],
        recieverName: json['reciever_name']);
  }
}
