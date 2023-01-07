class ChatModel {
  String docId;
  String lastMessage;
  DateTime lastMessageTime;
  String otherUserAvatar;
  String otherUserId;
  String otherUserName;
  String currentUserId;

  ChatModel(
      {required this.currentUserId,
      required this.docId,
      required this.lastMessage,
      required this.lastMessageTime,
      required this.otherUserAvatar,
      required this.otherUserId,
      required this.otherUserName});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
        currentUserId: json['user_id'],
        docId: json['doc_id'],
        lastMessage: json['last_message'],
        lastMessageTime:
            DateTime.parse(json['last_message_time'].toDate().toString()),
        otherUserAvatar: json['other_user_avatar'],
        otherUserId: json['other_user_id'],
        otherUserName: json['other_user_name']);
  }

  Map<String, dynamic> toJson() => {
        'user_id': currentUserId,
        'doc_id': docId,
        'last_message': lastMessage,
        'last_message_time': lastMessageTime,
        'other_user_avatar': otherUserAvatar,
        'other_user_id': otherUserId,
        'other_user_name': otherUserName
      };
}
