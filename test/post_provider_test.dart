import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_example/post.dart';
import 'package:mocktail_example/post_provider.dart';
import 'package:mocktail_example/post_repository_impl.dart';
import 'package:mocktail_example/post_state.dart';

class RepositoryMock extends Mock implements PostRepositoryImpl {}

void main() {
  final repositoryMock = RepositoryMock();
  final postProvider = PostProvider(repositoryMock);
  PostState postState = PostInitialState();
  const List<Post> mockList = [
    Post(title: 'title1', body: 'body1'),
    Post(title: 'title2', body: 'body2')
  ];

  void updateState(PostState state) {
    postState = state;
  }

  setUp(() {
    postProvider.addListener(() {
      updateState(postProvider.value);
    });
  });

  test('Post state should be successful after retrieving posts.', () async {
    when(() => repositoryMock.retrievePosts())
        .thenAnswer((_) async => mockList);

    expect(postState, isA<PostInitialState>());

    postProvider.retrievePosts();

    expect(postState, isA<PostLoadingState>());

    await Future.delayed(const Duration(seconds: 3));

    expect(postState, isA<PostSuccessState>());
  });

  test('Post state should be error after retrieving posts.', () async {
    when(() => repositoryMock.retrievePosts()).thenThrow('ops');

    await postProvider.retrievePosts();

    expect(postProvider.value, isA<PostErrorState>());
  });
}
