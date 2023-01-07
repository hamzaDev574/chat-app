import 'dart:developer';

import 'package:communication_app/models/chat_model.dart';
import 'package:flutter/material.dart';

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
          userId: userId, otherUserId: otherUserId);
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
  }) async {
    //TODO:
    try {
      isLoading = true;
      notifyListeners();
      final newMessage = await network.sendMessage(
          messageTime: messageTime, message: message, userId: userId);
      userMessages.insert(0, newMessage);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log('Error in send message $e');
    }
  }

  Future<void> createChat(
      {required ChatModel chat, required Map<String, dynamic> message}) async {
    try {
      isLoading = true;
      notifyListeners();
      await network.createUserChat(chat: chat);
      await sendMessage(
          messageTime: message['message_time'],
          message: message['message'],
          userId: message['user_id']);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log('Error in creating chat $e');
    }
  }
}
