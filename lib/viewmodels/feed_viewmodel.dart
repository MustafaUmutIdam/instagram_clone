
import 'package:instagram_clone/data/models/Post.dart';
import 'package:instagram_clone/data/models/story.dart';
import 'package:instagram_clone/data/repositories/repository.dart';

class FeedViewModel {
  final Repository repository =Repository();
  List<Post> posts = [];
  List<Story> stories = [];

  void loadPosts() {
    posts = repository.fetchPosts();
  }
  void loadStories() {
    stories = repository.fetchStories();
  }
}
