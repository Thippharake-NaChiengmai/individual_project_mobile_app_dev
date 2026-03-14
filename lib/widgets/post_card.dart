import 'package:flutter/material.dart';
import 'comment_widget.dart';

class Post {
  final String id;
  final String author;
  final String? avatarUrl;
  final String text;
  final String? imageUrl;
  final int likes;
  final List<Comment> comments;

  Post({
    required this.id,
    required this.author,
    required this.avatarUrl,
    required this.text,
    this.imageUrl,
    this.likes = 0,
    this.comments = const [],
  });
}

class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _liked = false;
  bool _showComments = false;

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                CircleAvatar(radius: 18, child: Text(post.author[0])),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.author,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '2h',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz),
                ),
              ],
            ),
          ),

          // Media
          if (post.imageUrl != null)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                post.imageUrl!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            )
          else
            Container(
              height: 220,
              color: Colors.grey[200],
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(post.text, style: const TextStyle(fontSize: 16)),
              ),
            ),

          // Actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => setState(() => _liked = !_liked),
                  icon: Icon(
                    _liked ? Icons.favorite : Icons.favorite_border,
                    color: _liked ? Colors.red : null,
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      setState(() => _showComments = !_showComments),
                  icon: const Icon(Icons.chat_bubble_outline),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_border),
                ),
              ],
            ),
          ),

          // Likes & caption
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${post.likes + (_liked ? 1 : 0)} likes',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: post.author + ' ',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: post.text,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                if (_showComments) ...[
                  for (final c in post.comments) CommentWidget(comment: c),
                ],
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
