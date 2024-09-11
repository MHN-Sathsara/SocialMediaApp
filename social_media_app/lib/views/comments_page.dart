import 'package:flutter/material.dart';
import '../controllers/comment_controller.dart';
import '../models/comment.dart';

class CommentsPage extends StatelessWidget {
  final int postId;
  final String postTitle;
  final String postBody;
  final CommentController commentController = CommentController();

  CommentsPage(
      {required this.postId, required this.postTitle, required this.postBody});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to home
          },
        ),
      ),
      body: Column(
        children: [
          // Post Title and Body
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(postTitle,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                SizedBox(height: 8),
                Text(postBody, style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_upward),
                      onPressed: () {
                        // Upvote post logic
                      },
                    ),
                    Text('0'), // Replace with dynamic count
                    IconButton(
                      icon: Icon(Icons.arrow_downward),
                      onPressed: () {
                        // Downvote post logic
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(),

          // Comments Section
          Expanded(
            child: FutureBuilder<List<Comment>>(
              future: commentController.fetchComments(postId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Comment comment = snapshot.data![index];
                      return ListTile(
                        leading:
                            Icon(Icons.person), // Placeholder for user icon
                        title: Text(comment.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(comment.body),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.arrow_upward),
                                  onPressed: () {
                                    // Upvote comment logic
                                  },
                                ),
                                Text('0'), // Replace with dynamic count
                                IconButton(
                                  icon: Icon(Icons.arrow_downward),
                                  onPressed: () {
                                    // Downvote comment logic
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No comments available.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
