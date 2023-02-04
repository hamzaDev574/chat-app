import 'dart:developer';

import 'package:communication_app/auth/models/user_model.dart';
import 'package:communication_app/models/chat_model.dart';
import 'package:flutter/material.dart';

import '../../network/network.dart';

class HomeNotifier extends ChangeNotifier {
  final network = Network();

  bool isLoading = false;

  List<ChatModel> userChats = List.empty(growable: true);
  List<UserModel> randomUsers = List.empty(growable: true);

  Future<void> getUserChats({required userId}) async {
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

  Future<void> getRandomUsers({required userId}) async {
    try {
      isLoading = true;
      notifyListeners();
      final users = await network.getRandomUsers(userId: userId);
      randomUsers = users;
      await getUserChats(userId: userId);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log('Error in chats: $e');
    }
  }

  void addNewChat({required ChatModel chat}) {
    userChats.insert(0, chat);
    notifyListeners();
  }
}
