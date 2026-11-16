import 'package:bloc/bloc.dart';

import '../../data/models/blog_post.dart';
import '../../data/repositories/blog_repository.dart';

class BlogState {
  const BlogState({required this.posts});

  final List<BlogPost> posts;
}

class BlogCubit extends Cubit<BlogState> {
  BlogCubit(this._repository) : super(BlogState(posts: _repository.getPosts()));

  final BlogRepository _repository;

  void addPost(BlogPost post) {
    final updatedPosts = [...state.posts, post];
    _repository.savePosts(updatedPosts);
    emit(BlogState(posts: updatedPosts));
  }

  void resetToDefault() {
    _repository.savePosts(BlogRepository.defaultPosts);
    emit(BlogState(posts: BlogRepository.defaultPosts));
  }
}
