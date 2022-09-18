import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communication_app/auth/models/user_model.dart';
import 'package:communication_app/models/chat_model.dart';
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
      {required email, required password, required userName}) async {
    try {
      Map<String, dynamic> userMap = {
        'email': email,
        'user_name': userName,
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
    print('INSIDE CHATS NETWORK');
    try {
      List<ChatModel> chats = List.empty(growable: true);
      final userChats = await _firestore
          .collection('Users')
          .doc(userId)
          .collection('chats')
          .get();
      for (final chat in userChats.docs) {
        chats.add(ChatModel.fromJson(chat.data()));
      }
      return chats;
    } catch (e) {
      rethrow;
    }
  }
}
