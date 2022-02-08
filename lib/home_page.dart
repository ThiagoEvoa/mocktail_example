import 'package:flutter/material.dart';
import 'package:mocktail_example/post_provider.dart';
import 'package:mocktail_example/post_state.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<PostProvider>().retrievePosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = context.watch<PostProvider>();

    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: postProvider,
        builder: (context, state, child) {
          switch (state.runtimeType) {
            case PostErrorState:
              return Center(child: Text((state as PostErrorState).error));
            case PostLoadingState:
            case PostInitialState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              final posts = (state as PostSuccessState).posts;

              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];

                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.body),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
