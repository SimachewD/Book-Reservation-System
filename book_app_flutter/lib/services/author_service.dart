import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/author.dart';

class AuthorService {
  static const String _baseUrl = 'http://localhost:10000/my_library/api/authors';

  // Fetch a list of all authors
  static Future<List<Author>> getAllAuthors() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Author.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load authors');
    }
  }

  // Fetch details of a specific author by ID
  static Future<Author?> getAuthorDetails(String authorId) async {
    final response = await http.get(Uri.parse('$_baseUrl/$authorId'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Author.fromJson(json);
    } else {
      throw Exception('Failed to load author details');
    }
  }
}
