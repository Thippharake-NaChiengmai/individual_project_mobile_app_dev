import 'package:flutter/material.dart';

class Comment {
  final String author;
  final String text;
  final List<Comment> replies;

  Comment({required this.author, required this.text, this.replies = const []});
}

class CommentWidget extends StatelessWidget {
  final Comment comment;

  const CommentWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(radius: 10, child: Icon(Icons.person, size: 10)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.author,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '· 2h',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(comment.text),
                if (comment.replies.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 8.0),
                    child: Column(
                      children: [
                        for (final r in comment.replies)
                          CommentWidget(comment: r),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
