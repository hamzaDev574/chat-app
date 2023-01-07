import 'package:flutter/material.dart';

class ChatHead extends StatelessWidget {
  ChatHead(
      {Key? key,
      required this.image,
      required this.title,
      required this.onChatTap})
      : super(key: key);
  String title;
  String image;
  VoidCallback onChatTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: onChatTap,
            child: Container(
                height: 55,
                width: 55,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    child: Image(image: NetworkImage(image)),
                  ),
                )
                // ClipOval(
                //   child: SizedBox.fromSize(
                //     size: const Size.fromRadius(40),
                //     child: image),
                // ),
                ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
