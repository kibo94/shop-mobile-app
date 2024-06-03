import 'package:flutter/cupertino.dart';

class Comment {
  String comment;
  String user;
  int id;
  Comment({required this.comment, required this.user, required this.id});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id: json['id'], user: json['user'], comment: json['comment']);
  }
}
