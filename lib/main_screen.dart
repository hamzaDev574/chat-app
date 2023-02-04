import 'dart:developer';

import 'package:communication_app/auth/models/user_model.dart';
import 'package:communication_app/auth/screens/login_page.dart';
import 'package:communication_app/chats/screens/conversation_screen.dart';
import 'package:communication_app/models/app_data.dart';
import 'package:communication_app/providers/change_notifiers/auth_notifier.dart';
import 'package:communication_app/providers/change_notifiers/home_notifier.dart';
import 'package:communication_app/widgets/chat_head.dart';
import 'package:communication_app/widgets/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const routeName = '/MainScreen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    final userId =
        Provider.of<AuthNotifier>(context, listen: false).currentUser!.uid;
    log(userId);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<HomeNotifier>(context, listen: false)
          .getRandomUsers(userId: userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/images/image1.jpeg'),
        ),
        title: Text(Provider.of<AuthNotifier>(context, listen: false)
            .currentUser!
            .userName),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<AuthNotifier>(context, listen: false).logOut();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              children: const [
                Text(
                  'Random Users',
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          Builder(builder: (context) {
            final isLoading = context
                .select<HomeNotifier, bool>((notifier) => notifier.isLoading);
            final users = context.select<HomeNotifier, List<UserModel>>(
                (notifier) => notifier.randomUsers);
            return Container(
              height: MediaQuery.of(context).size.height * 0.14,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              child: isLoading == true
                  ? const Center(child: Text('Loading data'))
                  : users.isEmpty
                      ? const Center(
                          child: Text('No active user found'),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            return ChatHead(
                                onChatTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ConversationScreen(
                                          userId: Provider.of<AuthNotifier>(
                                                  context,
                                                  listen: false)
                                              .currentUser!
                                              .uid,
                                          otherUserId: users[index].uid,
                                          otherUserName: users[index].userName,
                                          otherUserAvatar:
                                              users[index].avatarUrl),
                                    ),
                                  );
                                },
                                image: users[index].avatarUrl,
                                title: users[index].userName);
                          },
                        ),
            );
          }),
          Consumer<HomeNotifier>(builder: (context, notifier, child) {
            return Expanded(
              child: notifier.isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : notifier.userChats.isEmpty
                      ? Container(
                          color: Colors.white,
                          child: const Center(
                            child: Text('No chats found'),
                          ),
                        )
                      : Container(
                          color: Colors.white,
                          child: ListView.builder(
                              itemCount: notifier.userChats.length,
                              itemBuilder: (context, index) {
                                final indexItem = notifier.userChats[index];
                                return ChatTileWidget(
                                  onTap: () {
                                    //TODO:
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ConversationScreen(
                                            userId: Provider.of<AuthNotifier>(
                                                    context,
                                                    listen: false)
                                                .currentUser!
                                                .uid,
                                            otherUserId: indexItem.otherUserId,
                                            otherUserName:
                                                indexItem.otherUserName,
                                            otherUserAvatar:
                                                indexItem.otherUserAvatar),
                                      ),
                                    );
                                  },
                                  userName: indexItem.otherUserName,
                                  image: Image(
                                      image: NetworkImage(
                                          indexItem.otherUserAvatar)),
                                  lastMessage: indexItem.lastMessage,
                                  time: TimeOfDay.fromDateTime(
                                          indexItem.lastMessageTime)
                                      .toString(),
                                  unseenMessage: '',
                                );
                              }),
                        ),
            );
          }),
        ],
      ),
    );
  }
}
