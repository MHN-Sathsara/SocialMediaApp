class Post {
  final int id; // ID as int now
  final int userId;
  final String title;
  final String body;
  int upvotes;
  int downvotes;

  Post({
    required this.id, // Change this to int
    required this.userId,
    required this.title,
    required this.body,
    this.upvotes = 0,
    this.downvotes = 0,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? 0, // Ensure the ID is fetched correctly
      userId: json['userId'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      upvotes: json['upvotes'] ?? 0,
      downvotes: json['downvotes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, // Change this to 'id'
      'userId': userId,
      'title': title,
      'body': body,
      'upvotes': upvotes,
      'downvotes': downvotes,
    };
  }
}
