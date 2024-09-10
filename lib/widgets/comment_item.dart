import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/comment.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;
  final bool isReplyVisible;
  final VoidCallback onToggleReplies;
  final VoidCallback onReply;

  const CommentItem({
    super.key,
    required this.comment,
    required this.isReplyVisible,
    required this.onToggleReplies,
    required this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(

      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 16,
                  child: Text(comment.author[0]),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            comment.author,
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            formatTimestamp(comment.timestamp),
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        comment.content,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onToggleReplies,
                  child: Row(
                    children: [
                      Icon(
                        isReplyVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 18,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isReplyVisible ? 'Replies' : 'Replies',
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onReply,
                  icon: const Icon(Icons.subdirectory_arrow_left_outlined, size: 16),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  splashRadius: 20,
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_upward, size: 18),
                  onPressed: () {},
                  padding: const EdgeInsets.all(0),
                  constraints: const BoxConstraints(),
                ),
                const Text(
                  ('10'),
                ),
                const SizedBox(width: 6),
                IconButton(
                  icon: const Icon(Icons.arrow_downward, size: 18),
                  onPressed: () {},
                  padding: const EdgeInsets.all(0),
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ],
        ),

      ),
    );
  }
}

String formatTimestamp(Timestamp timestamp) {
  final date = timestamp.toDate();
  return '${date.month}/${date.day}/${date.year}';
}
