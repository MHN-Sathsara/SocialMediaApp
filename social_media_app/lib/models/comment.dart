class Comment {
  final String id;
  final int postId; // Ensure this is an int
  final String name;
  final String email;
  final String body;
  int upvotes; // Non-nullable
  int downvotes; // Non-nullable

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
      id: json['_id'] ?? '', // Ensure there's a fallback if '_id' is missing
      postId:
          int.parse(json['postId'].toString()), // Convert to int if necessary
      name: json['name'] ?? '', // Ensure fallback
      email: json['email'] ?? '', // Ensure fallback
      body: json['body'] ?? '', // Ensure fallback
      upvotes: json['upvotes'] ?? 0, // Handle optional field
      downvotes: json['downvotes'] ?? 0, // Handle optional field
    );
  }
}
