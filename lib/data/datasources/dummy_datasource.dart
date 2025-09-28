import 'package:instagram_clone/data/models/Post.dart';
import 'package:instagram_clone/data/models/profile.dart';
import 'package:instagram_clone/data/models/story.dart';
import 'package:instagram_clone/data/datasources/api_service.dart';

class DummyDataSource {
  final ApiService _apiService = ApiService();

  // API'den gerçek veri çek
  Future<List<Post>> getPostsFromApi() async {
    try {
      return await _apiService.getPosts();
    } catch (e) {
      // Hata durumunda fallback veri döndür
      print('API hatası: $e');
      return _getFallbackPosts();
    }
  }

  Future<List<Story>> getStoriesFromApi() async {
    try {
      return await _apiService.getStories();
    } catch (e) {
      print('Stories API hatası: $e');
      return _getFallbackStories();
    }
  }

  // Eski mock veri metodu (fallback olarak kullanılabilir)
  List<Post> getPosts() {
    return _getFallbackPosts();
  }

  List<Story> getStories() {
    return _getFallbackStories();
  }

  // Fallback/Mock veri
  List<Post> _getFallbackPosts() {
    return List.generate(5, (index) => Post(
      profileName: 'User$index',
      postDetail: 'Gönderi detay metni $index',
      images: [
        'https://picsum.photos/400/300?random=$index',
        'https://picsum.photos/400/300?random=${index+10}',
      ],
      timeAgo: '${index+1} saat önce',
      likeCount: 20+index,
      commentCount: 5+index,
      repostCount: 2+index,
    ));
  }

  List<Story> _getFallbackStories() {
    return [
      Story(
        id: 0,
        profileName: "Sen",
        profileImageUrl: "https://picsum.photos/100/100?random=50",
        isMine: true,
        hasStory: false,
      ),
      ...List.generate(5, (i) => Story(
        id: i + 1,
        profileName: "User$i",
        profileImageUrl: "https://picsum.photos/100/100?random=${i+60}",
      )),
    ];
  }

  Future<Profile> getProfileById(int id) async {
    try {
      return await _apiService.getProfileById(id);
    } catch (e) {
      print('Profile API hatası: $e');
      rethrow;
    }
  }

  Future<Profile> updateProfile(Profile profile) async {
    try {
      return await _apiService.updateProfile(profile);
    } catch (e) {
      print('Update profile API hatası: $e');
      rethrow;
    }
  }

}