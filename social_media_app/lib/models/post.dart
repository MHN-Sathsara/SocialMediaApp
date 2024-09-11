class Post {
  final int id;
  final int userId;
  final String title;
  final String body;
  int upvotes; // Add this field for upvotes
  int downvotes; // Optionally, you can also add downvotes if needed

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    this.upvotes = 0, // Initialize upvotes to 0
    this.downvotes = 0, // Initialize downvotes to 0
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
      upvotes: json['upvotes'] ?? 0, // Ensure upvotes field is handled
      downvotes: json['downvotes'] ?? 0, // Ensure downvotes field is handled
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
      'upvotes': upvotes, // Include upvotes in JSON
      'downvotes': downvotes, // Include downvotes in JSON
    };
  }
}
