import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/comment.dart';

class CommentController {
  final String apiUrl =
      'https://my-json-server.typicode.com/MHN-Sathsara/SocialMediaApp/comments';

  // Fetch comments based on postId
  Future<List<Comment>> fetchComments(String postId) async {
    print('Fetching comments...');
    final response = await http.get(Uri.parse(apiUrl));
    print('Raw comments response: ${response.body}');

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      // Filter comments by postId, ensuring both are strings
      List<Comment> filteredComments = jsonResponse
          .where((comment) =>
              comment['postId'].toString() ==
              postId.toString()) // Convert both to string
          .map((comment) => Comment.fromJson(comment))
          .toList();

      print('Filtered comments: $filteredComments');
      return filteredComments;
    } else {
      print('Failed to load comments. Status code: ${response.statusCode}');
      throw Exception('Failed to load comments');
    }
  }

  // Add a comment
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

    if (response.statusCode != 201) {
      throw Exception('Failed to add comment');
    }
  }
}
