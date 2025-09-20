import 'package:instagram_clone/data/datasources/yummy_datasource.dart';
import 'package:instagram_clone/data/models/Post.dart';
import 'package:instagram_clone/data/models/story.dart';

class Repository {
  final YummyDataSource dataSource =YummyDataSource();

  List<Post> fetchPosts() {
    return dataSource.getPosts();
  }

  List<Story> fetchStories() {
    return dataSource.getStories();
  }
}