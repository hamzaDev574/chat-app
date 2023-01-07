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
      List<ChatModel> chats = List.empty(growable: true);
      final userChats = await _firestore
          .collection('Chats')
          .where('user_id', isEqualTo: userId)
          .get();
      for (final chat in userChats.docs) {
        chats.add(ChatModel.fromJson(chat.data()));
      }
      return chats;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Message>> getUserMessages(
      {required String userId, required String otherUserId}) async {
    try {
      List<Message> messages = List.empty(growable: true);
      final to_user = await _firestore
          .collection('Chats')
          .where('user_id', isEqualTo: userId)
          .where('other_user_id', isEqualTo: otherUserId)
          .get();

      log('TO USER:: ${to_user.docs.length}');

      final from_user = await _firestore
          .collection('Chats')
          .where(
            'user_id',
            isEqualTo: otherUserId,
          )
          .where('other_user_id', isEqualTo: userId)
          .get();

      log('FROM USER:: ${from_user.docs.length}');

      // if (userMessages.docs.isEmpty) {
      return [];
      // } else {
      //TODO:
      // return [];
      //  for (final message in userMessages) {
      //   messages.add(Message.fromJson(message.data()));
      // }
      // log('USER MESSAGES:: ${messages.length}');
      // return messages;

      // }
      // .collection('Messages')
      // .get();

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

  Future<Message> sendMessage({
    required DateTime messageTime,
    required String message,
    required String userId,
  }) async {
    try {
      final docId = _firestore.collection('Chats').doc(userId).id;
      final rawMessage = {
        'doc_id': docId,
        'message': message,
        'message_time': messageTime,
        'user_id': userId
      };
      await _firestore
          .collection('Chats')
          .doc(userId)
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
}
