import 'package:instagram_clone/data/datasources/dummy_datasource.dart';
import 'package:instagram_clone/data/models/Post.dart';
import 'package:instagram_clone/data/models/story.dart';


class Repository {
  final DummyDataSource _dataSource = DummyDataSource();

  // Asenkron post çekme
  Future<List<Post>> fetchPosts() async {
    try {
      return await _dataSource.getPostsFromApi();
    } catch (e) {
      // Hata durumunda fallback veri döndür
      return _dataSource.getPosts();
    }
  }

  Future<List<Story>> fetchStories() async {
    try {
      return await _dataSource.getStoriesFromApi();
    } catch (e) {
      return _dataSource.getStories();
    }
  }
}