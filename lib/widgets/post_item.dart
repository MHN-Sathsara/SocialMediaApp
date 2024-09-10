import 'package:flutter/material.dart';
import 'package:redditclone_app/screens/comment_page.dart';
import '../models/post.dart';

// Widget to display a single post item
class PostItem extends StatefulWidget {
  final Post post;
  final VoidCallback onDelete;

  const PostItem({super.key, required this.post, required this.onDelete});

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  int voteCount = 25;
  bool isExpanded = false;
  bool isOverflowing = false;

  // Upvote function
  void upvote() {
    setState(() {
      voteCount++;
    });
  }

  // Downvote function
  void downvote() {
    setState(() {
      voteCount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.symmetric(vertical: 0.5),
          color: Theme.of(context).cardColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey[300]!, width: 0.5),
                bottom: BorderSide(color: Colors.grey[300]!, width: 0.5),
              ),
            ),
            child: Column(
              children: [
                // Post header and content
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Author info and options
                            Row(
                              children: [
                                // Author avatar
                                CircleAvatar(
                                  backgroundImage: NetworkImage(widget
                                          .post.authorProfileImageUrl ??
                                      'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?t=st=1725301260~exp=1725304860~hmac=3977e045bf3940139e558222bbeacf8b6bad2314598e51d3f0c61ab80b806904&w=740'),
                                  radius: 12,
                                ),
                                const SizedBox(width: 8),
                                // Author name
                                Text(
                                  widget.post.author,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(width: 4),
                                // Post time
                                Text(
                                  '2h', // Replace with actual time calculation if needed
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontSize: 10),
                                ),
                                const Spacer(),
                                // More options button
                                IconButton(
                                  icon: Transform.rotate(
                                    angle: 90 * 3.14159 / 180,
                                    child:
                                        const Icon(Icons.more_vert, size: 16),
                                  ),
                                  onPressed: () {
                                    // Show menu options
                                  },
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            // Post title
                            Text(
                              widget.post.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            // Post image (if available)
                            if (widget.post.imageUrl != null &&
                                widget.post.imageUrl!.isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  widget.post.imageUrl!,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            const SizedBox(height: 8),
                            // Post content with expandable text
                            LayoutBuilder(
                              builder: (context, constraints) {
                                final textSpan = TextSpan(
                                  text: widget.post.content,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                );

                                final textPainter = TextPainter(
                                  text: textSpan,
                                  maxLines: 3, // Limit to 3 lines
                                  textDirection: TextDirection.ltr,
                                  ellipsis: '...',
                                );

                                textPainter.layout(
                                  minWidth: constraints.minWidth,
                                  maxWidth: constraints.maxWidth,
                                );

                                isOverflowing = textPainter.didExceedMaxLines;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Post content
                                    Text(
                                      widget.post.content,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      maxLines: isExpanded ? null : 3,
                                      overflow: isExpanded
                                          ? TextOverflow.visible
                                          : TextOverflow.ellipsis,
                                    ),
                                    // Show more/less button
                                    if (isOverflowing)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 8),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isExpanded = !isExpanded;
                                              });
                                            },
                                            child: Text(
                                              isExpanded
                                                  ? 'Show less ..'
                                                  : 'Show full post ..',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Post actions (vote and comment)
                Container(
                  constraints: const BoxConstraints(
                    minHeight: 36,
                    maxHeight: 36,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 6.0),
                    child: Row(
                      children: [
                        // Vote buttons
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.2),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Upvote button
                                IconButton(
                                  icon:
                                      const Icon(Icons.arrow_upward, size: 18),
                                  onPressed: upvote,
                                  padding: const EdgeInsets.all(0),
                                  constraints: const BoxConstraints(),
                                ),
                                // Vote count
                                Text(
                                  '$voteCount',
                                  style: const TextStyle(fontSize: 11),
                                ),
                                const SizedBox(width: 6),
                                const VerticalDivider(
                                  width: 1,
                                  thickness: 0.2,
                                  color: Colors.grey,
                                ),
                                // Downvote button
                                IconButton(
                                  icon: const Icon(Icons.arrow_downward,
                                      size: 18),
                                  onPressed: downvote,
                                  padding: const EdgeInsets.all(0),
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Comment button
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.2),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.mode_comment_outlined,
                                    size: 18),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CommentScreen(post: widget.post),
                                    ),
                                  );
                                },
                                padding: const EdgeInsets.all(0),
                                constraints: const BoxConstraints(),
                              ),
                              // Comment count
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  '${widget.post.comments.length}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontSize: 11),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 115),
                        // Share button
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.2),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.share_rounded, size: 18),
                                onPressed: () {
                                  // Add share functionality here
                                },
                                padding: const EdgeInsets.all(0),
                                constraints: const BoxConstraints(),
                              ),
                              GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    'Share',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(fontSize: 11),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        const SizedBox(height: 2),
      ],
    );
  }
}
