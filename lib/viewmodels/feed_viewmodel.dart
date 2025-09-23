import 'package:flutter/foundation.dart';
import 'package:instagram_clone/data/models/Post.dart';
import 'package:instagram_clone/data/models/story.dart';
import 'package:instagram_clone/data/repositories/repository.dart';

class FeedViewModel extends ChangeNotifier {
  final Repository repository = Repository();

  List<Post> posts = [];
  List<Story> stories = [];

  bool _isLoading = false;
  String? _error;

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Posts yükleme metodu - artık asenkron
  Future<void> loadPosts() async {
    try {
      _setLoading(true);
      _setError(null);

      posts = await repository.fetchPosts();
      notifyListeners(); // UI'yi güncelle

    } catch (e) {
      _setError('Posts yüklenemedi: $e');
      debugPrint('Error loading posts: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadStories() async {
    try {
      stories = await repository.fetchStories();
      notifyListeners();
    } catch (e) {
      _setError('Stories yüklenemedi: $e');
    }
  }

  // Posts'ları yenileme metodu
  Future<void> refreshPosts() async {
    await loadPosts();
  }

  // Tüm verileri yükleme
  Future<void> loadAllData() async {
    loadStories(); // Senkron
    await loadPosts(); // Asenkron
  }

  // Private helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }
}