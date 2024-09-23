class Post {
  final String id; // ID as String
  final int userId;
  final String title;
  final String body;
  int upvotes;
  int downvotes;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    this.upvotes = 0,
    this.downvotes = 0,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'] ?? '', // Ensure the ID is fetched correctly
      userId: json['userId'] ?? 0, // Default to 0 if missing
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      upvotes: json['upvotes'] ?? 0, // Default to 0 if missing
      downvotes: json['downvotes'] ?? 0, // Default to 0 if missing
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id, // Use '_id' if that’s the expected key in the API
      'userId': userId,
      'title': title,
      'body': body,
      'upvotes': upvotes,
      'downvotes': downvotes,
    };
  }
}
