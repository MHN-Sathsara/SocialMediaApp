class Post {
  final String id;
  final String uniqueId;
  final int userId;
  final String title;
  final String body;
  final String content;
  final int timestamp;
  int upvotes;
  int downvotes;
  List<dynamic> comments;

  Post({
    required this.id,
    required this.uniqueId,
    required this.userId,
    required this.title,
    required this.body,
    required this.content,
    required this.timestamp,
    this.upvotes = 0,
    this.downvotes = 0,
    this.comments = const [],
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? '',
      uniqueId: json['uniqueId'] ?? '',
      userId: json['userId'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      content: json['content'] ?? '',
      timestamp: json['timestamp'] ?? 0,
      upvotes: json['upvotes'] ?? 0,
      downvotes: json['downvotes'] ?? 0,
      comments: json['comments'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uniqueId': uniqueId,
      'userId': userId,
      'title': title,
      'body': body,
      'content': content,
      'timestamp': timestamp,
      'upvotes': upvotes,
      'downvotes': downvotes,
      'comments': comments,
    };
  }
}
