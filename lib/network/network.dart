import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communication_app/auth/models/user_model.dart';
import 'package:communication_app/models/chat_model.dart';
import 'package:communication_app/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Network {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<UserModel> loginUser({required email, required password}) async {
    try {
      UserCredential firebaseUser = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (firebaseUser.user != null) {
        final userData = await _firestore
            .collection('Users')
            .doc(firebaseUser.user!.uid)
            .get();
        return UserModel.fromJson(userData.data()!);
      } else {
        throw 'No user record found';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> signupUser(
      {required email,
      required password,
      required userName,
      required avatarUrl}) async {
    try {
      Map<String, dynamic> userMap = {
        'email': email,
        'user_name': userName,
        'avatar_url': avatarUrl,
      };
      UserCredential firebaseUser = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (firebaseUser.user != null) {
        userMap = {...userMap, 'uid': firebaseUser.user!.uid};
        await _firestore
            .collection('Users')
            .doc(firebaseUser.user!.uid)
            .set(userMap);
        return UserModel.fromJson(userMap);
      } else {
        throw 'No user record found';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final firebaseuser = _firebaseAuth.currentUser;
      if (firebaseuser != null) {
        final userData =
            await _firestore.collection('Users').doc(firebaseuser.uid).get();
        return UserModel.fromJson(userData.data()!);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ChatModel>> getUserChats({required String userId}) async {
    try {
      final chats = await _firestore.collection('Chats').get();
      final userChats =
          chats.docs.map((e) => ChatModel.fromJson(e.data())).toList();
      final userAllChats =
          userChats.where((element) => element.currentUserId == userId);
      final moreUserchats =
          userChats.where((element) => element.otherUserId == userId);
      return [...userAllChats, ...moreUserchats];

      // if (chats.docs.isEmpty) {
      //   final chats = await _firestore
      //       .collection('Chats')
      //       .where('other_user_id', isEqualTo: userId)
      //       .get();
      //   return chats.docs.map((e) => ChatModel.fromJson(e.data())).toList();
      // } else {
      return chats.docs.map((e) => ChatModel.fromJson(e.data())).toList();
      // }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Message>> getUserMessages({required String docId}) async {
    try {
      final messages = await _firestore
          .collection('Chats')
          .doc(docId)
          .collection('Messages')
          .orderBy('message_time', descending: false)
          .get();

      return messages.docs.map((e) => Message.fromJson(e.data())).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createUserChat({required ChatModel chat}) async {
    try {
      await _firestore.collection('Chats').doc(chat.docId).set(chat.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<Message> sendMessage(
      {required DateTime messageTime,
      required String message,
      required String userId,
      required String chatDocId,
      required String otherUserId}) async {
    try {
      final docId = _firestore.collection('Chats').doc().id;
      final rawMessage = {
        'doc_id': docId,
        'message': message,
        'message_time': messageTime,
        'user_id': userId
      };
      await _firestore
          .collection('Chats')
          .doc(chatDocId)
          .update({'last_message': message});
      await _firestore
          .collection('Chats')
          .doc(chatDocId)
          .collection('Messages')
          .add(rawMessage);
      return Message.fromJson(rawMessage);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> getRandomUsers({required userId}) async {
    try {
      List<UserModel> users = List.empty(growable: true);
      final firebaseUsers = await _firestore
          .collection('Users')
          .where('uid', isNotEqualTo: userId)
          .get();
      log('FIREBASE USERS:: ${firebaseUsers.docs.length}');
      for (final user in firebaseUsers.docs) {
        users.add(UserModel.fromJson(user.data()));
      }
      return users;
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<Message>> liveChat({required String docId}) {
    return FirebaseFirestore.instance
        .collection('Chats')
        .doc(docId)
        .collection('Messages')
        .orderBy('message_time', descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Message.fromJson(e.data())).toList());
  }
}
