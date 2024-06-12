import 'dart:convert';

import 'package:my_app/models/comment.dart';

class CartProductModel {
  final int price;
  final String name;
  final id;
  int quantity;
  final String? type;
  final String author;
  final String details;
  int rating;
  bool inCart;
  bool isLiked;
  String? imgUrl;
  List<Comment>? comments;

  CartProductModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.type,
      required this.author,
      required this.inCart,
      required this.isLiked,
      required this.details,
      required this.rating,
      this.comments,
      this.imgUrl,
      required this.quantity});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'type': type,
      'inCart': inCart,
      "isLiked": isLiked,
      "details": details,
      "comments": comments,
      "imgUrl": imgUrl,
      "author": author
    };
  }
  // factory Product.fromJson(Map<String, dynamic> json) {
  //   var comments = <Comment>[];
  //   if (json['comments'] != null) {
  //     json['comments'].forEach((v) {
  //       comments.add(Comment.fromJson(v));
  //     });
  //   }
  //   return Product(
  //       id: json['id'],
  //       author: json['author'],
  //       name: json['name'],
  //       price: json['price'],
  //       quantity: json['quantity]'] ?? 0,
  //       inCart: json['inCart'] ?? false,
  //       isLiked: json['isLiked'] ?? false,
  //       details: json['details'],
  //       comments: comments,
  //       rating: json['rating'],
  //       imgUrl: json['imgUrl'],
  //       type: json['type']);
  // }
}
