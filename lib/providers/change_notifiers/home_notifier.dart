import 'dart:developer';

import 'package:communication_app/models/chat_model.dart';
import 'package:flutter/material.dart';

import '../../network/network.dart';

class HomeNotifier extends ChangeNotifier {
  final network = Network();

  bool isLoading = false;

  List<ChatModel> userChats = List.empty(growable: true);

  Future<void> getUserChats({required userId}) async {
    print('INSIDE CHATS NOTIFIER');
    try {
      isLoading = true;
      notifyListeners();
      final chats = await network.getUserChats(userId: userId);
      userChats = chats;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log('Error in chats: $e');
    }
  }
}
