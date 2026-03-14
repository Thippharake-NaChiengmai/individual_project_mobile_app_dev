import 'package:flutter/material.dart';

class StoryItem extends StatelessWidget {
  final String label;
  final String? imageUrl;

  const StoryItem({super.key, required this.label, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.pinkAccent, width: 2),
            image: imageUrl != null
                ? DecorationImage(
                    image: NetworkImage(imageUrl!),
                    fit: BoxFit.cover,
                  )
                : null,
            color: Colors.grey[200],
          ),
          child: imageUrl == null
              ? const Icon(Icons.person, color: Colors.white)
              : null,
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 72,
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class StoriesRow extends StatelessWidget {
  final int count;

  const StoriesRow({super.key, this.count = 8});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: count,
      itemBuilder: (context, i) {
        return StoryItem(
          label: 'User ${i + 1}',
          imageUrl: 'https://picsum.photos/seed/story$i/200',
        );
      },
    );
  }
}
