import 'package:book_app_flutter/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For local storage
import '../services/user_service.dart';

class AuthProvider extends ChangeNotifier {
  String? _id;
  String? _token;
  String? _email;
  bool _isLoading = false;
  String? _error;

  String? get id => _id;
  String? get token => _token;
  String? get email => _email;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Initialize the provider
  AuthProvider() {
    _loadUser();
  }

  // Load token from local storage
  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    _id = prefs.getString('user_id');
    _token = prefs.getString('auth_token');
    _email = prefs.getString('user_email');
    notifyListeners();
  }

  // Save token to local storage
  Future<void> _saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', user.id);
    await prefs.setString('auth_token', user.token);
    await prefs.setString('user_email', user.email);
  }

  // Create a new user account
  Future<void> createAccount(String email, String phone, String password) async {
    _setLoading(true);
    try {
      final user = await UserService.createAccount(email, phone, password);
      _id = user.id;
      _token = user.token;
      _email = user.email;
      await _saveUser(user);
      _error = null;
    } catch (e) {
      _error = e.toString().split(': ').last; 
    } finally {
      _setLoading(false);
    }
  }

  // Log in and save token
  Future<void> login(String email, String password) async {
    _setLoading(true);
    try {
      final user = await UserService.login(email, password);
      _id = user.id;
      _token = user.token;
      _email = user.email;
      await _saveUser(user);
      _error = null;
    } catch (e) {
      _error = e.toString().split(': ').last; 
    } finally {
      _setLoading(false);
    }
  }

  // Fetch user profile using token
  Future<void> fetchUserProfile() async {
    if (_token == null) return;

    _setLoading(true);
    try {
      await UserService.getUserProfile(_token!);
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // Log out by clearing the token
  Future<void> logout() async {
    _setLoading(true);
    try {
      _token = null;
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
      notifyListeners();
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // Utility method to set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
