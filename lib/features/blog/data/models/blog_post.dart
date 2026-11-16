class BlogPost {
  const BlogPost({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.category,
    required this.author,
    required this.imageUrl,
    required this.readTime,
    required this.likes,
    required this.featured,
  });

  final String id;
  final String title;
  final String excerpt;
  final String category;
  final String author;
  final String imageUrl;
  final String readTime;
  final int likes;
  final bool featured;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'excerpt': excerpt,
      'category': category,
      'author': author,
      'imageUrl': imageUrl,
      'readTime': readTime,
      'likes': likes,
      'featured': featured,
    };
  }

  factory BlogPost.fromMap(Map<String, dynamic> map) {
    return BlogPost(
      id: map['id'] as String,
      title: map['title'] as String,
      excerpt: map['excerpt'] as String,
      category: map['category'] as String,
      author: map['author'] as String,
      imageUrl: map['imageUrl'] as String,
      readTime: map['readTime'] as String,
      likes: (map['likes'] as num).toInt(),
      featured: map['featured'] as bool? ?? false,
    );
  }

  BlogPost copyWith({
    String? id,
    String? title,
    String? excerpt,
    String? category,
    String? author,
    String? imageUrl,
    String? readTime,
    int? likes,
    bool? featured,
  }) {
    return BlogPost(
      id: id ?? this.id,
      title: title ?? this.title,
      excerpt: excerpt ?? this.excerpt,
      category: category ?? this.category,
      author: author ?? this.author,
      imageUrl: imageUrl ?? this.imageUrl,
      readTime: readTime ?? this.readTime,
      likes: likes ?? this.likes,
      featured: featured ?? this.featured,
    );
  }
}
