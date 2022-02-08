import 'package:mocktail_example/post.dart';

abstract class PostRepository {
  Future<List<Post>> retrievePosts();
}
