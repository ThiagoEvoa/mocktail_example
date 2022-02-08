import 'package:dio/dio.dart';
import 'package:mocktail_example/post.dart';
import 'package:mocktail_example/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl(this.dio);

  final Dio dio;

  @override
  Future<List<Post>> retrievePosts() async {
    try {
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/posts');

      return Post.toList(response.data);
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
