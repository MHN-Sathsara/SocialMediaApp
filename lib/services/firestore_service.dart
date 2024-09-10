import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/comment.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch comments for a post
  Stream<List<Comment>> getComments(String postId) {
    return _db
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Comment.fromFirestore(doc)).toList());
  }

  // Add a comment to a post
  Future<void> addComment(String postId, Comment comment) async {
    try {
      await _db
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .add(comment.toFirestore());
    } catch (e) {
      print('Error adding comment: $e');
      rethrow; 
    }
  }

  // Fetch replies for a specific comment
  Stream<List<Comment>> getReplies(String postId, String commentId) {
    return _db
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .collection('replies')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Comment.fromFirestore(doc)).toList());
  }

  // Add a reply to a comment
  Future<void> addReply(String postId, String commentId, Comment reply) async {
    try {
      await _db
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .collection('replies')
          .add(reply.toFirestore());
    } catch (e) {
      print('Error adding reply: $e');
      rethrow; 
    }
  }
}