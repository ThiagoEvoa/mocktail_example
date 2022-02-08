import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mocktail_example/home_page.dart';
import 'package:mocktail_example/post_repository_impl.dart';
import 'package:mocktail_example/post_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Dio>(create: (_) => Dio()),
        Provider<PostRepositoryImpl>(
          create: (context) => PostRepositoryImpl(
            Provider.of<Dio>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => PostProvider(
            Provider.of<PostRepositoryImpl>(context, listen: false),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
