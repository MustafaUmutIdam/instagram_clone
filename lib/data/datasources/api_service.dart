import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:instagram_clone/data/models/Post.dart';
import 'package:instagram_clone/data/models/mypost.dart';
import 'package:instagram_clone/data/models/profile.dart';
import 'package:instagram_clone/data/models/story.dart';
import 'package:path/path.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5206';

  Future<List<Post>> getPosts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/posts'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Posts yüklenemedi: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('API çağrısında hata: $e');
    }
  }

  Future<List<Story>> getStories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/stories'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Story.fromJson(json)).toList();
      } else {
        throw Exception('Stories yüklenemedi: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Stories API çağrısında hata: $e');
    }
  }

  Future<Profile> getProfileById(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/profiles/$id'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      return Profile.fromJson(json.decode(response.body));
    } else {
      throw Exception('Profile yüklenemedi: ${response.statusCode}');
    }
  }

  Future<Profile> updateProfile(Profile profile) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/profiles/${profile.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(profile.toJson()),
    );

    if (response.statusCode == 200) {
      return Profile.fromJson(json.decode(response.body));
    } else {
      throw Exception('Profile güncellenemedi: ${response.statusCode}');
    }
  }

  // Upload images (form-data) -> returns List<String> imageUrls
  Future<List<String>> uploadImages(List<File> files) async {
    final uri = Uri.parse('$baseUrl/api/myposts/upload');
    final request = http.MultipartRequest('POST', uri);

    for (var file in files) {
      final stream = http.ByteStream(file.openRead());
      final length = await file.length();
      final multipartFile = http.MultipartFile(
        'files',
        stream,
        length,
        filename: basename(file.path),
      );
      request.files.add(multipartFile);
    }

    final streamedResponse = await request.send().timeout(const Duration(seconds: 30));
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final Map<String, dynamic> map = json.decode(response.body);
      // backend döndüğü gibi { "imageUrls": [ ... ] }
      final List<dynamic> urls = map['imageUrls'] ?? map['imageUrls'.toString()] ?? [];
      return List<String>.from(urls);
    } else {
      throw Exception('Resimler yüklenemedi: ${response.statusCode}');
    }
  }

  // Create MyPost (body as JSON)
  Future<MyPost> createMyPost(MyPost post) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/myposts'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(post.toJson()),
    ).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return MyPost.fromJson(json.decode(response.body));
    } else {
      throw Exception('Post oluşturulamadı: ${response.statusCode}');
    }
  }

  Future<List<MyPost>> fetchMyPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/api/MyPosts'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => MyPost.fromJson(json)).toList();
    } else {
      throw Exception("MyPosts alınamadı");
    }
  }

}
