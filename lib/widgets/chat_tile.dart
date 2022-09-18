import 'package:flutter/material.dart';

class ChatTileWidget extends StatelessWidget {
  const ChatTileWidget(
      {Key? key,
      required this.image,
      required this.userName,
      required this.lastMessage,
      required this.time,
      required this.unseenMessage,
      required this.onTap})
      : super(key: key);
  final String userName;
  final String lastMessage;
  final String time;
  final String unseenMessage;
  final VoidCallback onTap;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading:Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
         
          borderRadius: BorderRadius.circular(30)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: image),
      ),
      title: Text(
        userName,
        style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
      ),
      
      subtitle: Text(
        lastMessage,
        
        style: const TextStyle(color: Color.fromARGB(255, 117, 114, 114),),
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            time,
            style: const TextStyle(color: Colors.black),
          ),
          Text(
            unseenMessage,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
