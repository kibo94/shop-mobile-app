import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_app/models/comment.dart';

class Product {
  final int price;
  final String name;
  final id;
  final String? type;
  final String author;
  final String details;
  final bool onStack;
  int rating;
  bool inCart;
  bool isLiked;
  String? imgUrl;
  List<Comment>? comments;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.type,
    required this.author,
    required this.inCart,
    required this.isLiked,
    required this.details,
    required this.rating,
    required this.onStack,
    this.comments,
    this.imgUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var comments = <Comment>[];
    if (json['comments'] != null) {
      json['comments'].forEach((v) {
        comments.add(Comment.fromJson(v));
      });
    }
    return Product(
        id: json['id'],
        author: json['author'],
        name: json['name'],
        price: json['price'],
        onStack: json['onStack'] ?? false,
        inCart: json['inCart'] ?? false,
        isLiked: json['isLiked'] ?? false,
        details: json['details'],
        comments: comments,
        rating: json['rating'],
        imgUrl: json['imgUrl'],
        type: json['type']);
  }
}
