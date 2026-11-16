import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../data/models/blog_post.dart';
import '../bloc/blog_cubit.dart';
import 'create_post_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: BlocBuilder<BlogCubit, BlogState>(
            builder: (context, state) {
              final posts = state.posts;
              final featuredPost = posts.firstWhere(
                (post) => post.featured,
                orElse: () => posts.first,
              );

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Text(
                              'BlogVerse',
                              style: TextStyle(
                                color: AppPalette.textPrimary,
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const Spacer(),
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: AppPalette.panelLight,
                              child: const Text(
                                'M',
                                style: TextStyle(
                                  color: AppPalette.textPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: AppPalette.panel,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: AppPalette.border),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.search_rounded, color: AppPalette.subtle),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Search stories and authors',
                                  style: TextStyle(color: AppPalette.subtle),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          height: 40,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const [
                              _FilterChip(label: 'Featured'),
                              _FilterChip(label: 'Design'),
                              _FilterChip(label: 'Technology'),
                              _FilterChip(label: 'Productivity'),
                              _FilterChip(label: 'Writing'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 22),
                        _FeaturedCard(post: featuredPost),
                        const SizedBox(height: 24),
                        Row(
                          children: const [
                            Text(
                              'Latest stories',
                              style: TextStyle(
                                color: AppPalette.textPrimary,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: AppPalette.textSecondary,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final post = posts[index];
                        return _PostCard(post: post);
                      },
                      childCount: posts.length,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const CreatePostPage()));
        },
        backgroundColor: AppPalette.accent,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.edit_outlined),
        label: const Text('Write'),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppPalette.panel,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppPalette.border),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppPalette.textSecondary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({required this.post});

  final BlogPost post;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppPalette.border),
        color: AppPalette.panel,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: Image.network(
              post.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppPalette.accentSecondary.withOpacity(0.14),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        'Featured',
                        style: TextStyle(
                          color: AppPalette.accentSecondary,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.favorite_border_rounded,
                      color: AppPalette.textSecondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${post.likes}',
                      style: const TextStyle(color: AppPalette.textSecondary),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  post.title,
                  style: const TextStyle(
                    color: AppPalette.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  post.excerpt,
                  style: const TextStyle(
                    color: AppPalette.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=200&q=80',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      post.author,
                      style: const TextStyle(
                        color: AppPalette.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      post.readTime,
                      style: const TextStyle(color: AppPalette.subtle),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({required this.post});

  final BlogPost post;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: AppPalette.panel,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppPalette.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                post.imageUrl,
                height: 110,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppPalette.accentSecondary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      post.category,
                      style: const TextStyle(
                        color: AppPalette.accentSecondary,
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    post.title,
                    style: const TextStyle(
                      color: AppPalette.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    post.excerpt,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppPalette.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        post.author,
                        style: const TextStyle(
                          color: AppPalette.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        post.readTime,
                        style: const TextStyle(color: AppPalette.subtle),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
