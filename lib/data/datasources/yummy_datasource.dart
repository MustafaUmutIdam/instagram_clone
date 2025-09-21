import 'package:instagram_clone/data/models/Post.dart';
import 'package:instagram_clone/data/models/story.dart';
import 'package:instagram_clone/data/datasources/api_service.dart';

class YummyDataSource {
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

  // Eski mock veri metodu (fallback olarak kullanılabilir)
  List<Post> getPosts() {
    return _getFallbackPosts();
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

  // Stories için mock veri (değişiklik yok)
  List<Story> getStories() {
    return [
      Story(
        profileName: "Sen",
        profileImageUrl: "https://picsum.photos/100/100?random=50",
        isMine: true,
        hasStory: false,
      ),
      ...List.generate(8, (i) => Story(
        profileName: "User$i",
        profileImageUrl: "https://picsum.photos/100/100?random=${i+60}",
      )),
    ];
  }
}