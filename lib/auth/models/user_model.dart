import 'dart:developer';

class UserModel {
  String userName;
  String uid;
  String email;

  UserModel({required this.email, required this.uid, required this.userName});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    log('JSON:: $json');
    return UserModel(
        email: json['email'], uid: json['uid'], userName: json['user_name']);
  }

  Map<String, dynamic> toJson() =>
      {'email': email, 'uid': uid, 'user_name': userName};
}
