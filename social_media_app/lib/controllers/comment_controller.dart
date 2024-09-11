import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/comment.dart';

class CommentController {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/comments';

  // Fetch comments for a specific post
  Future<List<Comment>> fetchComments(int postId) async {
    final response = await http.get(Uri.parse('$apiUrl?postId=$postId'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((comment) => Comment.fromJson(comment)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }
}
