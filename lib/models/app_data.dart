import 'package:flutter/material.dart';
class Chats{
  Image image;
  String title;
  String time;
  String decription;
  String messagen;
  List<ChatMessage>? chatMessage;

  Chats({
    required this.image,
    required this.title,
    required this.decription,
    required this.time,
    required this.messagen,
    this.chatMessage,


  });



}

class ChatMessage{
  String message;
  bool isMe;

  ChatMessage({
    required this.isMe,
    required this.message
  });
}

List <Chats> allchats =[
  Chats(image: const Image(image: AssetImage('assets/images/image1.jpeg'),fit: BoxFit.fill,), title:'Emilia', decription: 'hey how you doing?', time:'3:02' , messagen: '5',
  
   chatMessage:[
    ChatMessage(isMe: true, message: 'Hello'),
    ChatMessage(isMe: false, message: 'Hi!'),
    ChatMessage(isMe: true, message: 'How are you'),
    ChatMessage(isMe: false, message: 'I\'m good what about you?'),
    

  ]),

  
  Chats(image: const Image(image: AssetImage('assets/images/image2.jpeg'),fit: BoxFit.fill,), title:'jhon', decription: 'are you busy today?', time:'4:02' , messagen: '',chatMessage: [

    ChatMessage(isMe: true, message: 'are you going out today?'),
    ChatMessage(isMe: true, message: 'answer me quickly'),
    ChatMessage(isMe:true, message: 'I am going out now.......'),
    ChatMessage(isMe: false, message: 'sorry i will be a little late today')
  ]
  
  ),
   Chats(image: const Image(image: AssetImage('assets/images/image2.jpeg'),fit: BoxFit.fill,), title:'jhon', decription: 'are you busy today?', time:'4:02' , messagen: '',chatMessage: [

    ChatMessage(isMe: true, message: 'are you going out today?'),
    ChatMessage(isMe: true, message: 'answer me quickly'),
    ChatMessage(isMe:true, message: 'I am going out now.......'),
    ChatMessage(isMe: false, message: 'sorry i will be a little late today')
  ]
  
  ),
   Chats(image: const Image(image: AssetImage('assets/images/image2.jpeg'),fit: BoxFit.fill,), title:'jhon', decription: 'are you busy today?', time:'4:02' , messagen: '',chatMessage: [

    ChatMessage(isMe: true, message: 'are you going out today?'),
    ChatMessage(isMe: true, message: 'answer me quickly'),
    ChatMessage(isMe:true, message: 'I am going out now.......'),
    ChatMessage(isMe: false, message: 'sorry i will be a little late today'),
    ChatMessage(isMe: false, message: 'sorry i will be a little late today'),
    ChatMessage(isMe: false, message: 'sorry i will be a little late today'),
    ChatMessage(isMe: false, message: 'sorry i will be a little late today'),
    ChatMessage(isMe: false, message: 'sorry i will be a little late today'),
     ChatMessage(isMe: false, message: 'sorry i will be a little late today'),
      ChatMessage(isMe: false, message: 'sorry i will be a little late today'),
       ChatMessage(isMe: false, message: 'sorry i will be a little late today'),
        ChatMessage(isMe: false, message: 'sorry i will be a little late today'),
  
    
  ]
  
  ),
  Chats(image: const Image(image: AssetImage('assets/images/i3.jpeg'),fit: BoxFit.fill,), title:'Clarke', decription: 'we need to talk', time:'11:42' , messagen: '',chatMessage: [

    ChatMessage(isMe: true, message: 'Predict the personality traits to understand how the author of the written text makes decisions, whether they are Emotional (relationship-oriented, focusing on social values and empathy) or Rational (objective and pragmatic, focusing on facts and logical deduction'),
    ChatMessage(isMe: true, message: 'hahahhahahha'),
    ChatMessage(isMe:true, message: 'hey ypou are you okay'),
    ChatMessage(isMe: false, message: 'anwer ti quicklyy')
  ]),
  Chats(image: const Image(image: AssetImage('assets/images/i4.jpeg'),fit: BoxFit.fill,), title:'Stephen', decription: 'hurry up where are you', time:'2:02' , messagen:'',chatMessage: [

    ChatMessage(isMe: true, message: 'hey john are you waiting'),
    ChatMessage(isMe: true, message: 'common i am waiting'),
    ChatMessage(isMe:true, message: 'got it   '),
    ChatMessage(isMe: false, message: 'LINE Messaging API lets you develop two-way communication between your service and LINE users. Push and reply messages Push messages are messages that your bot can send to users at any time. Reply messages')
  ] ),
  Chats(image: const Image(image: AssetImage('assets/images/i5.jpeg'),fit: BoxFit.fill,), title:'Rachael', decription: 'why you didnt came to school today?', time:'5:09' , messagen: '',chatMessage: [

    ChatMessage(isMe: true, message: 'BotDelive is a cloud communication platform for developers. It allows developers to send and receive 2FA and Push Notification via chatbots.'),
    ChatMessage(isMe: true, message: 'okay meet you tommorow '),
    ChatMessage(isMe:true, message: 'not tommorow today i am free'),
    ChatMessage(isMe: false, message: 'sorry i will be a little late today')
  ]),
  Chats(image: const Image(image: AssetImage('assets/images/i6.jpeg'),fit: BoxFit.fill,), title:'Marie', decription: 'did you just arrived at the school?', time:'10:03' , messagen: '6',chatMessage: [

    ChatMessage(isMe: true, message: 'are you going out today?'),
    ChatMessage(isMe: true, message: 'answer me quickly'),
    ChatMessage(isMe:true, message: 'I am going out now.......'),
    ChatMessage(isMe: false, message: 'sorry i will be a little late today')
  ]),
   Chats(image: const Image(image: AssetImage('assets/images/i6.jpeg'),fit: BoxFit.fill,), title:'Marie', decription: 'did you just arrived at the school?', time:'10:03' , messagen: '',chatMessage: [

    ChatMessage(isMe: true, message: 'are you going out today?'),
    ChatMessage(isMe: true, message: 'answer me quickly'),
    ChatMessage(isMe:true, message: 'I am going out now.......'),
    ChatMessage(isMe: false, message: 'sorry i will be a little late today')
  ]),
    Chats(image: const Image(image: AssetImage('assets/images/image1.jpeg'),fit: BoxFit.fill,), title:'Emilia', decription: 'hey how you doing?', time:'3:02' , messagen: '',chatMessage: [

    ChatMessage(isMe: true, message: 'are you going out today?'),
    ChatMessage(isMe: true, message: 'answer me quickly'),
    ChatMessage(isMe:true, message: 'I am going out now.......'),
    ChatMessage(isMe: false, message: 'sorry i will be a little late today')
  ]),


];