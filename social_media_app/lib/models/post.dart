class Post {
  int id;
  int userId;
  String title;
  String body;

  Post(
      {required this.id,
      required this.userId,
      required this.title,
      required this.body});

  // Factory method to create a Post from JSON
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }
}
