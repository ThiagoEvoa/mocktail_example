import 'package:mocktail_example/post.dart';

abstract class PostState {}

class PostInitialState extends PostState {}

class PostLoadingState extends PostState {}

class PostSuccessState extends PostState {
  PostSuccessState({required this.posts});

  final List<Post> posts;
}

class PostErrorState extends PostState {
  PostErrorState({required this.error});

  final String error;
}
