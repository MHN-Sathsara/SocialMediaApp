import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/post.dart';

class PostController {
  final String apiUrl =
      'https://crudcrud.com/api/719448c322a346e4ab17e58eac1ce701/posts';

  // Fetch posts from the API
  Future<List<Post>> fetchPosts() async {
    print('Fetching posts...');
    final response = await http.get(Uri.parse(apiUrl));
    print('Response: ${response.body}');

    if (response.statusCode == 200) {
      print('Posts fetched successfully');
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) {
        print('Processing post: ${post['title']}');
        return Post.fromJson({
          'id': post['_id'] ?? '',
          'title': post['title'] ?? '',
          'body': post['body'] ?? '',
          'userId': post['userId'] ?? 0,
        });
      }).toList();
    } else {
      print('Failed to load posts. Status code: ${response.statusCode}');
      throw Exception('Failed to load posts');
    }
  }

  Future<void> addPost(Post newPost) async {
    print('Adding new post...');
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
      print('Failed to add post. Status code: ${response.statusCode}');
      throw Exception('Failed to add post');
    }
  }

  Future<void> updatePost(Post post) async {
    print('Updating post...');
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
      print('Failed to update post. Status code: ${response.statusCode}');
      throw Exception('Failed to update post');
    }
  }

  Future<void> deletePost(String id) async {
    print('Deleting post...');
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      print('Post deleted successfully!');
    } else {
      print('Failed to delete post. Status code: ${response.statusCode}');
      throw Exception('Failed to delete post');
    }
  }
}
