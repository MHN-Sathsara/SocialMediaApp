class Comment {
  final String id;
  final String postId;
  final String name;
  final String email;
  final String body;
  int? upvotes; // Optional field for upvotes
  int? downvotes;

  Comment({
    required this.id,
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
    this.upvotes = 0,
    this.downvotes = 0,
  });


factory Comment.fromJson(Map<String, dynamic> json) {
  return Comment(
    id: json['_id'], // Use '_id' if that's the field name in the response
    postId: json['postId'],
    name: json['name'],
    email: json['email'],
    body: json['body'],
  );
}
}
