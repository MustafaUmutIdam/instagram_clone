import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:instagram_clone/data/models/Post.dart';

class ApiService {
  // Android emulator için 10.0.2.2 kullanın
  // Gerçek cihaz için bilgisayarınızın IP adresini kullanın
  static const String baseUrl = 'http://10.0.2.2:5206'; // HTTP kullanın HTTPS yerine

  // Alternatif: Gerçek cihaz için
  // static const String baseUrl = 'http://192.168.1.XXX:5206'; // IP adresinizi yazın

  Future<List<Post>> getPosts() async {
    try {
      print('API çağrısı yapılıyor: $baseUrl/api/posts');

      final response = await http.get(
        Uri.parse('$baseUrl/api/posts'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10)); // Timeout ekleyin

      print('API yanıt kodu: ${response.statusCode}');
      print('API yanıt body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Posts yüklenemedi: ${response.statusCode}');
      }
    } on SocketException catch (e) {
      print('Bağlantı hatası: $e');
      throw Exception('Sunucuya bağlanılamadı. Backend çalışıyor mu?');
    } on HttpException catch (e) {
      print('HTTP hatası: $e');
      throw Exception('HTTP hatası: $e');
    } on FormatException catch (e) {
      print('JSON parse hatası: $e');
      throw Exception('Geçersiz veri formatı');
    } catch (e) {
      print('Genel hata: $e');
      throw Exception('API çağrısında hata: $e');
    }
  }
}