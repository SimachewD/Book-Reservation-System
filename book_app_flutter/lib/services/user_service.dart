import 'dart:convert';
import 'package:book_app_flutter/models/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const String _baseUrl = 'http://localhost:10000';

  // Create a new user account
  static Future<User> createAccount(
      String email, String phone, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/my_library/api/user/createaccount'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'phone': phone,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return User.fromJson(json);
    } else {
      final json = jsonDecode(response.body);
      throw Exception(json['Error']) ;
    }
  }

  // Log in to the app
  static Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/my_library/api/user/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return User.fromJson(json); 
    } 
    else {
      final json = jsonDecode(response.body);
      throw Exception(json['Error']) ;
    }
  }

  // Fetch user profile
  static Future<Map<String, dynamic>> getUserProfile(String token) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/user/profile'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user profile');
    }
  }
}
