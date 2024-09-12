import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/comment.dart';

class CommentController {
  final String apiUrl =
      'https://my-json-server.typicode.com/MHN-Sathsara/SocialMediaApp/comments';

  // Fetch comments for a specific post
  Future<List<Comment>> fetchComments(String postId) async {
    print('Fetching comments for post ID: $postId');
    final response = await http.get(Uri.parse('$apiUrl?postId=$postId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((data) => Comment.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  // Add a new comment
  Future<void> addComment(Comment newComment) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'postId': newComment.postId,
        'name': newComment.name,
        'email': newComment.email,
        'body': newComment.body,
      }),
    );

    if (response.statusCode == 201) {
      print('Comment added successfully');
    } else {
      throw Exception('Failed to add comment');
    }
  }
}
