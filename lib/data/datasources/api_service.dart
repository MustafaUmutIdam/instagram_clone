import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:instagram_clone/data/models/Post.dart';
import 'package:instagram_clone/data/models/story.dart';

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
}
