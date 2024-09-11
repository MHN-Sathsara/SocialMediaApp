import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/post.dart';

class PostController {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  // Fetch posts from the API
  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<void> addPost(Post newPost) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'title': newPost.title,
        'body': newPost.body,
        'userId': newPost.userId,
      }),
    );

    if (response.statusCode == 201) {
      print('Post added successfully!');
    } else {
      throw Exception('Failed to add post');
    }
  }

  Future<void> updatePost(Post post) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${post.id}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'title': post.title,
        'body': post.body,
        'userId': post.userId,
      }),
    );

    if (response.statusCode == 200) {
      print('Post updated successfully!');
    } else {
      throw Exception('Failed to update post');
    }
  }

  Future<void> deletePost(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      print('Post deleted successfully!');
    } else {
      throw Exception('Failed to delete post');
    }
  }
}
