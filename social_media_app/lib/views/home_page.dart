import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/post_controller.dart';
import '../models/post.dart';
import 'add_post_page.dart';
import 'comment_page.dart';
import 'edit_post_page.dart';

class HomePage extends StatelessWidget {
  final PostController postController = PostController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: FutureBuilder<List<Post>>(
        future: postController.fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Post post = snapshot.data![index];
                return ListTile(
                  leading: Icon(Icons.person), // Placeholder for user profile
                  title: Text(post.title),
                  subtitle: Text(post.body),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        // Navigate to EditPostPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPostPage(post: post),
                          ),
                        );
                      } else if (value == 'delete') {
                        // Call deletePost
                        postController.deletePost(post.id);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Navigate to Comments Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentPage(
                          post: post,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No posts available.'));
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Post',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            // Navigate to AddPostPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPostPage()),
            );
          }
        },
      ),
    );
  }
}
