import 'package:instagram_clone/data/datasources/dummy_datasource.dart';
import 'package:instagram_clone/data/models/Post.dart';
import 'package:instagram_clone/data/models/story.dart';


class Repository {
  final YummyDataSource _dataSource = YummyDataSource();

  // Asenkron post çekme
  Future<List<Post>> fetchPosts() async {
    try {
      return await _dataSource.getPostsFromApi();
    } catch (e) {
      // Hata durumunda fallback veri döndür
      return _dataSource.getPosts();
    }
  }

  // Stories için mock veri (değişiklik yok)
  List<Story> fetchStories() {
    return _dataSource.getStories();
  }
}