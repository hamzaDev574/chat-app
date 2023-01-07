import 'dart:developer';

import 'package:communication_app/models/chat_model.dart';
import 'package:communication_app/providers/change_notifiers/auth_notifier.dart';
import 'package:communication_app/providers/change_notifiers/chat_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/message.dart';

class ConversatoinScreen extends StatefulWidget {
  const ConversatoinScreen(
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
  State<ConversatoinScreen> createState() => _ConversatoinScreenState();
}

class _ConversatoinScreenState extends State<ConversatoinScreen> {
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
        // leading: const Icon(Icons.arrow_back_sharp),
        title: Row(
          children: [
            Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(30)),
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
          Icon(
            Icons.video_call,
          ),
          SizedBox(
            width: 15,
          ),
          Icon(Icons.call)
        ],
      ),
      body: Builder(builder: (context) {
        final isLoading = context
            .select<ChatNotifier, bool>((notifier) => notifier.isLoading);
        final userMessages = context.select<ChatNotifier, List<Message>>(
            (notifier) => notifier.userMessages);
        final userId = context.read<AuthNotifier>().currentUser!.uid;
        return Column(
          children: [
            Expanded(
              child: isLoading == true && userMessages.isEmpty
                  ? Center(
                      child:
                          Text('Creating chat with ${widget.otherUserName}..'),
                    )
                  : isLoading == true
                      ? Center(
                          child: Text(
                              'Loading your chat with ${widget.otherUserName}..'),
                        )
                      : userMessages.isEmpty
                          ? Center(
                              child: Text(
                                  'Send your first message to ${widget.otherUserName}'),
                            )
                          : Container(
                              child: ListView.builder(
                                  itemCount: userMessages.length,
                                  itemBuilder: (context, index) {
                                    final indexItem = userMessages[index];
                                    return Row(
                                      mainAxisAlignment:
                                          userMessages[index].userId == userId
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(10),
                                          width: 150.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            color: const Color.fromARGB(
                                                255, 221, 125, 157),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12.0, left: 5.0),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0, bottom: 10.0),
                                              child: Text(indexItem.message),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                            ),
            ),
            // const Expanded(child: TextField())
            TextField(
              style: const TextStyle(color: Colors.black),
              controller: messageController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20))),
                  prefixIcon: const Icon(
                    Icons.add,
                    color: Colors.grey,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Write a message',
                  hintStyle: const TextStyle(color: Colors.grey),
                  // icon: Icon(Icons.emoji_emotions),
                  suffixIcon: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.emoji_emotions,
                          color: Colors.grey,
                        ),
                        IconButton(
                          onPressed: () async {
                            if (messageController.text.isEmpty) {
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
                                  docId: userId,
                                  lastMessage: messageController.text,
                                  lastMessageTime: DateTime.now(),
                                  otherUserAvatar: widget.otherUserAvatar,
                                  otherUserId: widget.otherUserId,
                                  otherUserName: widget.otherUserName);
                              await Provider.of<ChatNotifier>(context,
                                      listen: false)
                                  .createChat(chat: chat, message: {
                                'message_time': DateTime.now(),
                                'message': messageController.text,
                                'user_id': userId
                              });
                            } else {
                              await Provider.of<ChatNotifier>(context,
                                      listen: false)
                                  .sendMessage(
                                      messageTime: DateTime.now(),
                                      message: messageController.text,
                                      userId: userId);
                            }
                          },
                          icon: const Icon(
                            Icons.send,
                          ),
                        )
                      ],
                    ),
                  )),
            )
          ],
        );
      }),

      //  Padding(
      //   padding: const EdgeInsets.only(top:625.0),
      //   child: Expanded(child: TextField(
      // decoration: InputDecoration(
      //   prefixIcon: const Icon(Icons.add,color: Colors.grey,),
      //   fillColor: Colors.white,
      //   hintText: 'Write a message',
      //   // icon: Icon(Icons.emoji_emotions),
      //   suffixIcon:SizedBox(
      //     width: 100,
      //     child: Row(children: const [
      //       Icon(Icons.emoji_emotions,color: Colors.grey,),
      //       SizedBox(
      //         width: 30.0,
      //       ),
      //       Icon(Icons.send,color: Colors.grey,)
      //     ],),

      //   )

      // ),

      //   )),
      // )

      // bottomNavigationBar:  BottomNavigationBar(items: const <BottomNavigationBarItem>[

      // ]),
    );
  }
}
