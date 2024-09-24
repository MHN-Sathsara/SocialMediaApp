import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/comment.dart'; // Import your comment model

class CommentController {
  final String apiUrl = 'http://10.0.2.2:3000/api/v1/comments';

  // Fetch comments for a specific post
  Future<List<Comment>> fetchComments(int postId) async {
    final response = await http.get(Uri.parse('$apiUrl/$postId/comments'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((comment) => Comment.fromJson(comment)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  // Add a comment to a post
  Future<void> addComment(Comment newComment) async {
    final response = await http.post(
      Uri.parse('$apiUrl/${newComment.postId}/comments'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'content': newComment.body,
        'userId': newComment.email, // assuming userId as email for now
      }),
    );

    if (response.statusCode == 201) {
      print('Comment added successfully!');
    } else {
      throw Exception('Failed to add comment');
    }
  }

  // Update a comment
  Future<void> updateComment(Comment comment) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${comment.postId}/comments/${comment.id}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'content': comment.body,
        'userId': comment.email,
      }),
    );

    if (response.statusCode == 200) {
      print('Comment updated successfully!');
    } else {
      throw Exception('Failed to update comment');
    }
  }

  // Delete a comment
  Future<void> deleteComment(int postId, String commentId) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/$postId/comments/$commentId'),
    );

    if (response.statusCode == 200) {
      print('Comment deleted successfully!');
    } else {
      throw Exception('Failed to delete comment');
    }
  }
}
