class Post {
  final String id; // Change to String
  final int userId;
  final String title;
  final String body;
  int upvotes;
  int downvotes;

  Post({
    required this.id, // String ID now
    required this.userId,
    required this.title,
    required this.body,
    this.upvotes = 0,
    this.downvotes = 0,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'] ?? '', // Handle string ID
      userId: json['userId'] ?? 0, // Default to 0 if missing
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      upvotes: json['upvotes'] ?? 0,
      downvotes: json['downvotes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
      'upvotes': upvotes,
      'downvotes': downvotes,
    };
  }
}
