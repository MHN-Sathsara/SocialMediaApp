import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String id;
  final String content;
  final String author;
  final Timestamp timestamp;
  final String? profileImageUrl;
  final List<Comment>? replies; 
  int upvotes; // Add this line
  int downvotes; // Add this line

  Comment({
    required this.id,
    required this.content,
    required this.author,
    required this.timestamp,
    this.profileImageUrl,
    this.replies,
    this.upvotes = 0, // Initialize to 0
    this.downvotes = 0, // Initialize to 0
  });

  // Firestore document to Comment model
  factory Comment.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Comment(
      id: doc.id,
      content: data['content'] ?? '',
      author: data['author'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
      profileImageUrl: data['profileImageUrl'],
      replies: data['replies'] != null 
          ? List<Comment>.from(data['replies'].map((reply) => Comment.fromFirestore(reply))) 
          : [],
      upvotes: data['upvotes'] ?? 0, // Initialize from Firestore
      downvotes: data['downvotes'] ?? 0, // Initialize from Firestore
    );
  }

  // Comment model to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'content': content,
      'author': author,
      'timestamp': timestamp,
      'profileImageUrl': profileImageUrl,
      'upvotes': upvotes, // Add this line
      'downvotes': downvotes, // Add this line
    };
  }
}