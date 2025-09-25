import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/data/repositories/repository.dart';
import 'package:instagram_clone/logic/profile/profile_bloc.dart';
import 'package:instagram_clone/ui/screens/home_page.dart';

void main() {
  final repository = Repository();

  runApp(
    MultiBlocProvider(
      providers: [
       // BlocProvider(create: (_) => PostsBloc(repository)..add(LoadPosts())),
       //BlocProvider(create: (_) => StoriesBloc(repository)..add(LoadStories())),
        BlocProvider(create: (_) => ProfileBloc(repository)), // event UI’dan tetiklenecek
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      home: const HomePage(),
    );
  }
}
