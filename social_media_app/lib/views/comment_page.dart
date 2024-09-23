import 'package:flutter/material.dart';
import '../controllers/comment_controller.dart';
import '../models/comment.dart';
import '../models/post.dart';

class CommentPage extends StatefulWidget {
  final Post post;

  CommentPage({required this.post});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final CommentController commentController = CommentController();
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.post.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(widget.post.body),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_upward),
                          onPressed: () {
                            // Add upvote logic here
                          },
                        ),
                        Text('${widget.post.upvotes}'),
                        IconButton(
                          icon: Icon(Icons.arrow_downward),
                          onPressed: () {
                            // Add downvote logic here
                          },
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () {
                        // Handle add comment logic
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: FutureBuilder<List<Comment>>(
              future: commentController.fetchComments(int.parse(
                  widget.post.id as String)), // Convert widget.post.id to int
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error loading comments'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No comments yet'));
                }

                final comments = snapshot.data!;
                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return _buildCommentThread(comment);
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: 'Add a comment...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () async {
                  if (_commentController.text.isNotEmpty) {
                    final newComment = Comment(
                      id: '',
                      postId: int.parse(widget.post.id
                          as String), // Convert widget.post.id to int here as well
                      name: 'User',
                      email: 'user@example.com',
                      body: _commentController.text,
                      upvotes: 0,
                      downvotes: 0,
                    );

                    try {
                      await commentController.addComment(newComment);
                      _commentController.clear();
                      setState(() {}); // Refresh the comments
                    } catch (error) {
                      print('Failed to add comment: $error');
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommentThread(Comment comment) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                child: Icon(Icons.person),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(comment.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(comment.body),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_upward),
                onPressed: () {
                  // Handle comment upvote logic
                },
              ),
              Text('${comment.upvotes}'),
              IconButton(
                icon: Icon(Icons.arrow_downward),
                onPressed: () {
                  // Handle comment downvote logic
                },
              ),
              TextButton(
                onPressed: () {
                  // Show reply form logic
                },
                child: Text('Reply'),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
