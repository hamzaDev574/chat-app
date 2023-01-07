import 'dart:developer';

import 'package:communication_app/auth/models/user_model.dart';
import 'package:communication_app/main_screen.dart';
import 'package:communication_app/network/network.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthNotifier extends ChangeNotifier {
  final network = Network();

  bool isLoading = false;
  UserModel? currentUser;

  Future<void> loginUser(
      {required email, required password, required context}) async {
    try {
      isLoading = true;
      notifyListeners();
      final user = await network.loginUser(email: email, password: password);
      currentUser = user;
      isLoading = false;
      notifyListeners();
      Navigator.pushReplacementNamed(context, MainScreen.routeName);
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log('Error in login: $e');
    }
  }

  Future<void> signupUser(
      {required email,
      required password,
      required userName,
      required BuildContext context}) async {
    try {
      isLoading = true;
      notifyListeners();
      final user = await network.signupUser(
          email: email,
          password: password,
          userName: userName,
          avatarUrl:
              'https://toppng.com/uploads/preview/cool-avatar-transparent-image-cool-boy-avatar-11562893383qsirclznyw.png');
      currentUser = user;
      isLoading = false;
      notifyListeners();
      Navigator.pushReplacementNamed(context, MainScreen.routeName);
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log('Error in login: $e');
    }
  }

  Future<void> getCurrentUser() async {
    try {
      final user = await network.getCurrentUser();
      currentUser = user;
      notifyListeners();
    } catch (e) {
      log('Error in currenUser: $e');
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    currentUser = null;
  }
}
