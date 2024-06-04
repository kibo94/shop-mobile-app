class Comment {
  String comment;
  String user;
  int id;
  int rating;
  Comment({
    required this.comment,
    required this.user,
    required this.id,
    required this.rating,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      user: json['user'],
      comment: json['comment'],
      rating: json['rating'] ?? 1,
    );
  }
}
