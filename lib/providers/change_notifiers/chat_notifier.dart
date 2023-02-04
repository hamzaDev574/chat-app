import 'dart:developer';

import 'package:communication_app/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/message.dart';
import '../../network/network.dart';

//TODO: make notifier states

class ChatNotifier extends ChangeNotifier {
  Network network = Network();
  bool isLoading = false;

  List<Message> userMessages = List.empty(growable: true);

  Future<void> getUserConversation(
      {required String userId, required String otherUserId}) async {
    try {
      isLoading = true;
      notifyListeners();
      userMessages = await network.getUserMessages(
          docId: createChatId(senderId: userId, recieverId: otherUserId));
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log('Error in conversation: $e');
    }
  }

  Future<void> sendMessage({
    required DateTime messageTime,
    required String message,
    required String userId,
    required String otherUserId,
  }) async {
    //TODO:
    try {
      isLoading = true;
      notifyListeners();
      final newMessage = await network.sendMessage(
          messageTime: messageTime,
          message: message,
          userId: userId,
          chatDocId: createChatId(senderId: userId, recieverId: otherUserId),
          otherUserId: otherUserId);
      userMessages.add(newMessage);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log('Error in send message $e');
    }
  }

  Future<void> createChat(
      {required ChatModel chat,
      required Map<String, dynamic> message,
      required String otherUserId}) async {
    try {
      isLoading = true;
      notifyListeners();
      await network.createUserChat(chat: chat);
      await sendMessage(
          messageTime: message['message_time'],
          message: message['message'],
          userId: message['user_id'],
          otherUserId: otherUserId);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log('Error in creating chat $e');
    }
  }

  String createChatId({
    required String senderId,
    required String recieverId,
  }) {
    if (senderId.hashCode <= recieverId.hashCode) {
      return '$senderId-$recieverId';
    } else {
      return '$recieverId-$senderId';
    }
  }

  Stream<List<Message>> liveChat(
      {required String userId, required String otherUserId}) {
    return network.liveChat(
        docId: createChatId(senderId: userId, recieverId: otherUserId));
  }
}
