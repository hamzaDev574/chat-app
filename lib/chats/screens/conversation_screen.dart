import 'package:communication_app/chats/screens/widgets/message_bubble.dart';
import 'package:communication_app/models/chat_model.dart';
import 'package:communication_app/providers/change_notifiers/auth_notifier.dart';
import 'package:communication_app/providers/change_notifiers/chat_notifier.dart';
import 'package:communication_app/providers/change_notifiers/home_notifier.dart';
import 'package:communication_app/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/message.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen(
      {Key? key,
      required this.otherUserId,
      required this.otherUserName,
      required this.otherUserAvatar,
      required this.userId})
      : super(key: key);

  final String otherUserName;
  final String otherUserId;
  final String otherUserAvatar;
  final String userId;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChatNotifier>(context, listen: false).getUserConversation(
          userId: widget.userId, otherUserId: widget.otherUserId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kPrimary,
        title: Row(
          children: [
            CircleAvatar(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image(
                  image: NetworkImage(widget.otherUserAvatar),
                ),
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Text(widget.otherUserName),
          ],
        ),
        actions: const [
          //TODO:
          Icon(
            Icons.video_call,
          ),
          SizedBox(
            width: 15,
          ),
          Icon(Icons.call)
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: Provider.of<ChatNotifier>(context).liveChat(
                  userId: widget.userId, otherUserId: widget.otherUserId),
              builder: (context, AsyncSnapshot<List<Message>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else {
                  final messages = snapshot.data;
                  return messages == null || messages.isEmpty
                      ? Center(
                          child: Text(
                              'Start your conversation with ${widget.otherUserName}'),
                        )
                      : ListView.builder(
                          reverse: true,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final indexItem = messages[index];
                            return MessageBubble(message: indexItem);
                          });
                }
              },
            ),
          ),
          SafeArea(
            child: TextField(
              style: const TextStyle(color: Colors.white),
              controller: messageController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  filled: true,
                  fillColor: AppColors.kPrimary,
                  hintText: 'Write a message ...',
                  hintStyle: const TextStyle(color: Colors.white),
                  suffixIcon: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            //TODO:
                          },
                          icon: const Icon(
                            Icons.emoji_emotions,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            if (messageController.text.isEmpty) {
                              return;
                            }
                            if (messageController.text.length > 700) {
                              return;
                            }
                            if (Provider.of<ChatNotifier>(context,
                                    listen: false)
                                .userMessages
                                .isEmpty) {
                              final userId = Provider.of<AuthNotifier>(context,
                                      listen: false)
                                  .currentUser!
                                  .uid;
                              final chat = ChatModel(
                                  currentUserId: userId,
                                  docId: Provider.of<ChatNotifier>(context,
                                          listen: false)
                                      .createChatId(
                                          senderId: userId,
                                          recieverId: widget.otherUserId),
                                  lastMessage: messageController.text,
                                  lastMessageTime: DateTime.now(),
                                  otherUserAvatar: widget.otherUserAvatar,
                                  otherUserId: widget.otherUserId,
                                  otherUserName: widget.otherUserName);
                              await Provider.of<ChatNotifier>(context,
                                      listen: false)
                                  .createChat(
                                      chat: chat,
                                      message: {
                                        'message_time': DateTime.now(),
                                        'message': messageController.text,
                                        'user_id': userId,
                                      },
                                      otherUserId: widget.otherUserId);
                              Provider.of<HomeNotifier>(context, listen: false)
                                  .addNewChat(chat: chat);
                              messageController.clear();
                            } else {
                              await Provider.of<ChatNotifier>(context,
                                      listen: false)
                                  .sendMessage(
                                      messageTime: DateTime.now(),
                                      message: messageController.text,
                                      userId: widget.userId,
                                      otherUserId: widget.otherUserId);
                              messageController.clear();
                            }
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
