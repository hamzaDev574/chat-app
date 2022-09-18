import 'package:communication_app/models/app_data.dart';
import 'package:flutter/material.dart';

class ConversatoinScreen extends StatelessWidget {
  const ConversatoinScreen(
      {Key? key, required this.messages, required this.userName,required this.image})
      : super(key: key);

  final List<ChatMessage> messages;
  final String userName;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_sharp),
        title: Row(
          
       
          children: [
         
          Container(
            
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              color: Colors.amber,
              
              borderRadius: BorderRadius.circular(30)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: image),
          ),
          const SizedBox(width: 15.0,),
          Text(userName),

        ],),
       
        actions: const [
        
          Icon(Icons.video_call,),
          SizedBox(width: 15,),
          
          Icon(Icons.call)
        ],
      ),
      body: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: messages[index].isMe
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            width: 150.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: const Color.fromARGB(255, 221, 125, 157),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 12.0, left: 5.0),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, bottom: 10.0),
                                child: Text(messages[index].message),
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
                       children: const [
                        Icon(
                          Icons.emoji_emotions,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                        Icon(
                          Icons.send,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  )),
            )
          ],
        ),
      
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
