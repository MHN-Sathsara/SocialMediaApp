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
      id: json['id'],
      postId: json['postId'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
      upvotes: json['upvotes'] ?? 0,
      downvotes: json['downvotes'] ?? 0,
    );
  }
}
