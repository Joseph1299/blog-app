import 'package:hive/hive.dart';

import '../models/blog_post.dart';

class BlogRepository {
  BlogRepository([Box<dynamic>? box]) : _box = box ?? Hive.box('blog_app');

  final Box<dynamic> _box;

  List<BlogPost> getPosts() {
    final rawPosts = _box.get('posts', defaultValue: <Map<String, dynamic>>[]);
    if (rawPosts is! List) {
      return defaultPosts;
    }

    final parsed = rawPosts.whereType<Map>().map((entry) {
      final map = Map<String, dynamic>.from(entry);
      return BlogPost.fromMap(map);
    }).toList();

    if (parsed.isEmpty) {
      return defaultPosts;
    }

    return parsed;
  }

  void savePosts(List<BlogPost> posts) {
    _box.put('posts', posts.map((post) => post.toMap()).toList());
  }

  static const List<BlogPost> defaultPosts = [
    BlogPost(
      id: '1',
      title: 'How to build a meaningful morning routine',
      excerpt: 'A calm daily ritual can improve energy, focus, and the intention you carry into the rest of your week.',
      category: 'Productivity',
      author: 'Maya Chen',
      imageUrl: 'https://images.unsplash.com/photo-1499951360447-b19be8fe80f5?auto=format&fit=crop&w=800&q=80',
      readTime: '6 min read',
      likes: 240,
      featured: true,
    ),
    BlogPost(
      id: '2',
      title: 'Designing spaces that encourage deep work',
      excerpt: 'The right environment can improve creativity, learning, and the ability to maintain momentum without burnout.',
      category: 'Design',
      author: 'Aisha Patel',
      imageUrl: 'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=800&q=80',
      readTime: '4 min read',
      likes: 182,
      featured: false,
    ),
    BlogPost(
      id: '3',
      title: 'The next wave of AI for creators',
      excerpt: 'A thoughtful adoption strategy helps creators use AI for ideation, acceleration, and better storytelling.',
      category: 'Technology',
      author: 'Jules Martin',
      imageUrl: 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?auto=format&fit=crop&w=800&q=80',
      readTime: '8 min read',
      likes: 312,
      featured: true,
    ),
  ];
}
