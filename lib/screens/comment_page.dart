import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:redditclone_app/widgets/post_item.dart';
import '../services/firestore_service.dart';
import '../models/post.dart';
import '../models/comment.dart';
import '../widgets/comment_item.dart';

class CommentScreen extends StatefulWidget {
  final Post post;

  const CommentScreen({super.key, required this.post});

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _inputController = TextEditingController();

  bool _isTyping = false;
  String? _replyToCommentId; // Keeps track of the comment being replied to
  final Map<String, bool> _isReplyVisible = {}; // Track visibility of replies

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  Future<void> _submitInput() async {
    if (_inputController.text.isEmpty) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final username = userDoc['username'] ?? 'Anonymous';

      if (_replyToCommentId == null) {
        // Post a new comment
        final comment = Comment(
          id: '',
          content: _inputController.text.trim(),
          author: username,
          timestamp: Timestamp.now(),
        );
        await FirestoreService().addComment(widget.post.id, comment);
      } else {
        // Post a reply to a specific comment
        final reply = Comment(
          id: '',
          content: _inputController.text.trim(),
          author: username,
          timestamp: Timestamp.now(),
        );
        await FirestoreService()
            .addReply(widget.post.id, _replyToCommentId!, reply);
      }

      _inputController.clear();
      setState(() {
        _isTyping = false;
        _replyToCommentId = null;
      });
    } catch (e) {
      print('Error submitting input: $e');
    }
  }

  // Function to toggle the visibility of replies for a comment
  void _toggleReplyVisibility(String commentId) {
    setState(() {
      _isReplyVisible[commentId] = !(_isReplyVisible[commentId] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: theme.appBarTheme.backgroundColor,
        ),
        body: Column(
          children: [
            Expanded(
              // Stream builder for comments
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .doc(widget.post.id)
                    .collection('comments')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                        child:
                            Text('Error loading comments: ${snapshot.error}'));
                  }

                  return CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                      ),
                      // Display the original post
                      SliverToBoxAdapter(
                        child: PostItem(
                          post: widget.post,
                          onDelete: () {},
                        ),
                      ),
                      // Add space between post and comments
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 16),
                      ),
                      // Display comments or "No comments yet" message
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
                        const SliverToBoxAdapter(
                          child: Center(child: Text('No comments yet')),
                        )
                      else
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final doc = snapshot.data!.docs[index];
                              final comment = Comment.fromFirestore(doc);
                              final commentId = doc.id; // Get the comment ID

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Pass relevant data and functions to CommentItem
                                  CommentItem(
                                    comment: comment,
                                    isReplyVisible:
                                        _isReplyVisible[commentId] ?? false,
                                    onToggleReplies: () {
                                      _toggleReplyVisibility(commentId);
                                    },
                                    onReply: () {
                                      setState(() {
                                        _replyToCommentId = commentId;
                                      });
                                      _inputController.text =
                                          ''; // Clear input field
                                    },
                                  ),
                                  // Display replies if visible
                                  if (_isReplyVisible[commentId] == true)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 32.0),
                                      child: StreamBuilder<List<Comment>>(
                                        stream: FirestoreService().getReplies(
                                            widget.post.id, commentId),
                                        builder: (context, replySnapshot) {
                                          if (replySnapshot.hasError) {
                                            return Center(
                                              child: Text(
                                                  'Error loading replies: ${replySnapshot.error}'),
                                            );
                                          }
                                          if (!replySnapshot.hasData ||
                                              replySnapshot.data!.isEmpty) {
                                            return const Center(
                                                child: Text('No replies yet'));
                                          }

                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: replySnapshot.data!
                                                .map((reply) => Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16.0),
                                                      child: ListTile(
                                                        title: CommentItem(
                                                          comment: reply,
                                                          isReplyVisible: false,
                                                          onToggleReplies:
                                                              () {},
                                                          onReply: () {},
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                          );
                                        },
                                      ),
                                    ),
                                ],
                              );
                            },
                            childCount: snapshot.data?.docs.length ?? 0,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
            // Comment/Reply text field
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      onChanged: (text) {
                        setState(() {
                          _isTyping = text.isNotEmpty;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: _replyToCommentId == null
                            ? 'Add comment'
                            : 'Add reply',
                        filled: true,
                        fillColor: theme.cardColor,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: theme.dividerColor),
                        ),
                      ),
                    ),
                  ),
                  if (_isTyping)
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.blue),
                      onPressed: _submitInput,
                    ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
    );
  }
}
