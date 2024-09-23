import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/post.dart';

class PostController {
  final String apiUrl = 'http://10.0.2.2:3000/api/v1/posts';

  // Fetch posts from the API
  Future<List<Post>> fetchPosts() async {
    print('Fetching posts...');
    try {
      final response = await http.get(Uri.parse(apiUrl));
      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        print('Posts fetched successfully');
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((post) {
          return Post.fromJson({
            'id': post['id'].toString(), // Convert id to String if necessary
            'title': post['content'] ?? '', // Use 'content' instead of 'title'
            'body':
                post['imageUrl'] ?? '', // Optional, if using imageUrl as body
            'userId': post['userId'] ?? 0,
          });
        }).toList();
      } else {
        print('Failed to load posts. Status code: ${response.statusCode}');
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      print('Error fetching posts: $e');
      throw e;
    }
  }

  // Add a new post
  Future<void> addPost(Post newPost) async {
    print('Adding new post...');
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'content': newPost.title, // 'content' field for post content
          'userId': newPost.userId,
          'imageUrl': newPost.body, // Optional, if using imageUrl
        }),
      );

      if (response.statusCode == 201) {
        print('Post added successfully!');
      } else {
        print('Failed to add post. Status code: ${response.statusCode}');
        throw Exception('Failed to add post: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error adding post: $e');
      throw e;
    }
  }

  // Update a post
  Future<void> updatePost(Post post) async {
    print('Updating post...');
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/${post.id}'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'content': post.title, // 'content' field for post content
          'userId': post.userId,
          'imageUrl': post.body, // Optional, if using imageUrl
        }),
      );

      if (response.statusCode == 200) {
        print('Post updated successfully!');
      } else {
        print('Failed to update post. Status code: ${response.statusCode}');
        throw Exception('Failed to update post: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error updating post: $e');
      throw e;
    }
  }

  // Delete a post
  Future<void> deletePost(String id) async {
    print('Deleting post...');
    try {
      final response = await http.delete(Uri.parse('$apiUrl/$id'));

      if (response.statusCode == 200) {
        print('Post deleted successfully!');
      } else {
        print('Failed to delete post. Status code: ${response.statusCode}');
        throw Exception('Failed to delete post: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error deleting post: $e');
      throw e;
    }
  }
}
