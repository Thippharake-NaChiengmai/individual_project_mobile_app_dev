import 'package:flutter/material.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/post_card.dart';
import '../widgets/comment_widget.dart';
import '../widgets/story_item.dart';

const _sampleText = 'Images by https://picsum.photos/';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    final posts = List.generate(
      8,
      (i) => Post(
        id: 'p$i',
        author: 'User ${i + 1}',
        avatarUrl: null,
        text: '$_sampleText (post ${i + 1})',
        imageUrl: i % 3 == 0 ? 'https://picsum.photos/seed/$i/600/300' : null,
        likes: 3 * i + 1,
        comments: List.generate(
          i % 3 + 1,
          (j) => Comment(
            author: 'Commenter ${j + 1}',
            text: 'Nice post! (reply $j)',
            replies: j == 0
                ? [Comment(author: 'ReplyUser', text: 'Agree!')]
                : [],
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "662115019 Individual Project",
          style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: isMobile
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_box_outlined),
                  label: 'Add',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border),
                  label: 'Likes',
                ),
                BottomNavigationBarItem(
                  icon: CircleAvatar(
                    radius: 12,
                    child: Icon(Icons.person, size: 14),
                  ),
                  label: 'Profile',
                ),
              ],
            )
          : null,
      body: ResponsiveLayout(
        mobile: _buildList(context, posts, maxWidth: double.infinity),
        tablet: Row(
          children: [
            Container(
              width: 72,
              padding: const EdgeInsets.only(left: 8),
              child: const _LeftNav(),
            ),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: _buildList(context, posts, maxWidth: 760),
                ),
              ),
            ),
          ],
        ),
        desktop: Row(
          children: [
            Container(
              width: 72,
              padding: const EdgeInsets.only(left: 8),
              child: const _LeftNav(),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: _buildList(context, posts, maxWidth: 860),
                ),
              ),
            ),
            Container(
              width: 320,
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: const _SidebarPlaceholder(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    List<Post> posts, {
    required double maxWidth,
  }) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      itemCount: posts.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        if (index == 0) {
          return const SizedBox(height: 110, child: StoriesRow());
        }
        return PostCard(post: posts[index - 1]);
      },
    );
  }
}

class _SidebarPlaceholder extends StatelessWidget {
  const _SidebarPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trending',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: const [
                    Chip(label: Text('#Wellness')),
                    Chip(label: Text('#tierlist')),
                    Chip(label: Text('#low-cositol')),
                    Chip(label: Text('#funny')),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person)),
                  title: Text('Demo User'),
                  subtitle: Text('View profile'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text('Follow'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_horiz),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LeftNav extends StatelessWidget {
  const _LeftNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        IconButton(onPressed: () {}, icon: const Icon(Icons.home_outlined)),
        const SizedBox(height: 6),
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        const SizedBox(height: 6),
        IconButton(onPressed: () {}, icon: const Icon(Icons.add_box_outlined)),
        const SizedBox(height: 6),
        IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: CircleAvatar(
            radius: 16,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person, size: 14),
            ),
          ),
        ),
      ],
    );
  }
}
