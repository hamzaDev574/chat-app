import 'package:communication_app/chats/screens/conversation_screen.dart';
import 'package:communication_app/models/app_data.dart';
import 'package:communication_app/widgets/chat_head.dart';
import 'package:communication_app/widgets/chat_tile.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const routeName = '/MainScreen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> chatHeadItemList = [
    ChatHead(
        image: const Image(
          image: AssetImage('assets/images/image1.jpeg'),
          fit: BoxFit.fill,
        ),
        title: 'Emilia'),
    ChatHead(
        image: const Image(
          image: AssetImage('assets/images/image2.jpeg'),
          fit: BoxFit.fill,
        ),
        title: 'Jhon'),
    ChatHead(
        image: const Image(
          image: AssetImage('assets/images/i3.jpeg'),
          fit: BoxFit.fill,
        ),
        title: 'Clarke'),
    ChatHead(
        image: const Image(
          image: AssetImage('assets/images/i4.jpeg'),
          fit: BoxFit.fill,
        ),
        title: 'Stephen'),
    ChatHead(
        image: const Image(
          image: AssetImage('assets/images/i5.jpeg'),
          fit: BoxFit.fill,
        ),
        title: 'Rachael'),
    ChatHead(
        image: const Image(
          image: AssetImage('assets/images/i6.jpeg'),
          fit: BoxFit.fill,
        ),
        title: 'Marie'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/images/image1.jpeg'),
        ),
        actions: const [Icon(Icons.search)],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 13.0, top: 18.0),
            child: Row(
              children: const [
                Text(
                  'Messages',
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.14,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: chatHeadItemList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: chatHeadItemList[index],
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                  itemCount: allchats.length,
                  itemBuilder: (context, index) {
                    return ChatTileWidget(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ConversatoinScreen(
                                    messages: allchats[index].chatMessage!,
                                    userName: allchats[index].title,
                                    image:allchats[index].image,
                                    ))),
                        userName: allchats[index].title,
                        image: allchats[index].image,
                        lastMessage: allchats[index].decription,
                        time: allchats[index].time,
                        unseenMessage: allchats[index].messagen);
                  }),
            ),
          )
        ],
      ),
    );
  }
}
