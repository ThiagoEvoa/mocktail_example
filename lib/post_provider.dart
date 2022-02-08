import 'package:flutter/material.dart';
import 'package:mocktail_example/post_repository.dart';
import 'package:mocktail_example/post_state.dart';

class PostProvider extends ValueNotifier<PostState> {
  PostProvider(this._postRepository) : super(PostInitialState());

  final PostRepository _postRepository;

  Future<void> retrievePosts() async {
    try {
      value = PostLoadingState();
      final posts = await _postRepository.retrievePosts();
      value = PostSuccessState(posts: posts);
    } catch (ex) {
      value = PostErrorState(error: ex.toString());
    }
  }
}
