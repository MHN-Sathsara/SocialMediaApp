import 'package:redditclone_app/models/comment.dart';

class Post {
  final String id;
  final String title;
  final String content;
  final String author;
  final String? authorProfileImageUrl;
  final String? imageUrl; 
  final List<Comment> comments;
  

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    this.authorProfileImageUrl,
    this.imageUrl,
    this.comments = const [],
  });
}
