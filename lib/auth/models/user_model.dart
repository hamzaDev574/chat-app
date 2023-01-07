import 'dart:developer';

class UserModel {
  String userName;
  String uid;
  String email;
  String avatarUrl;

  UserModel(
      {required this.email,
      required this.uid,
      required this.userName,
      required this.avatarUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    log('JSON:: $json');
    return UserModel(
        email: json['email'],
        uid: json['uid'],
        userName: json['user_name'],
        avatarUrl: json['avatar_url']);
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'uid': uid,
        'user_name': userName,
        'avatar_url': avatarUrl
      };
}
