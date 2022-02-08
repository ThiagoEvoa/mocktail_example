import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_example/post.dart';
import 'package:mocktail_example/post_repository_impl.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dioMock = DioMock();
  final postRepository = PostRepositoryImpl(dioMock);
  final requestOptions = RequestOptions(path: '');
  const jsonMock = [
    {"title": "title1", "body": "body1"},
    {"title": "title2", "body": "body2"}
  ];

  test('Should retrieve the posts', () async {
    when(() => dioMock.get(any())).thenAnswer(
      (_) async => Response(
        data: jsonMock,
        requestOptions: requestOptions,
      ),
    );

    final posts = await postRepository.retrievePosts();

    expect(posts, isA<List<Post>>());
  });

  test('Should throw an exception when trying to retrieve the posts.', () {
    when(() => dioMock.get(any())).thenThrow('ops');

    expect(
      () async => await postRepository.retrievePosts(),
      throwsA(isA<Exception>()),
    );
  });
}
