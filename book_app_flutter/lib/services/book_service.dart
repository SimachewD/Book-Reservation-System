import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart'; // Import your book model here

class BookService {
  static const String _baseUrl =
      'http://localhost:10000/my_library/api/books';

  // Fetch a list of all books
  static Future<List<Book>> getAllBooks() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  // Fetch details of a specific book by ID
  static Future<Book?> getBookDetails(String bookId) async {
    final response = await http.get(Uri.parse('$_baseUrl/bookdetails/$bookId'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Book.fromJson(json);
    } else {
      throw Exception('Failed to load book details');
    }
  }

  //Fetch featured books
  static Future<List<Book>> getFeaturedBooks() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList
            .map((json) =>
                Book.fromJson(json)) // Map each JSON object to a Book instance
            .where((book) => book.status == 'popular') // Filter by status
            .toList(); // Convert the Iterable to a List
      } else {
        throw Exception('Failed to load featured books');
      }
    } catch (e) {
      throw Exception('Server error! Check your Connection');
    }
  }

  //Fetch featured books
  static Future<List<Book>> getNewReleasedBooks() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList
            .map((json) =>
                Book.fromJson(json)) // Map each JSON object to a Book instance
            .where((book) => book.status == 'new release') // Filter by status
            .toList(); // Convert the Iterable to a List
      } else {
        throw Exception('Failed to load new books');
      }
    } catch (e) {
      throw Exception('Server error! Check your Connection');
    }
  }

  // Fetch favorite books for a user
  static Future<List<Book>> getFavoriteBooks() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load favorite books');
    }
  }

  // Fetch reserved books for a user
  static Future<List<Book>> getReservedBooks(String userId) async {
    final response = await http.get(Uri.parse('$_baseUrl?userId=$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load reserved books');
    }
  }

  // Fetch pending books for a user
  static Future<List<Book>> getPendingBooks(String userId) async {
    final response = await http.get(Uri.parse('$_baseUrl?userId=$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pending books');
    }
  }

  // Fetch purchased books for a user
  static Future<List<Book>> getPurchasedBooks(String userId) async {
    final response = await http.get(Uri.parse('$_baseUrl?userId=$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load purchased books');
    }
  }

  // Reserve a book
  static Future<void> reserveBook(
      String bookId, String userId, String token, DateTime dueDate) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/reservebook'),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'bookId': bookId,
        'userId': userId,
        'status': 'pending',
        'dueDate': dueDate.toIso8601String()
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to reserve book');
    }
  }

  // Cancel a reservation
  static Future<void> cancelReservation(String reservationId) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$reservationId'));

    if (response.statusCode != 200) {
      throw Exception('Failed to cancel reservation');
    }
  }

  // Add a book to favorites
  static Future<void> addFavorite(String bookId, String userId) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'bookId': bookId,
        'userId': userId,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add to favorites');
    }
  }

  // Delete a book from favorites
  static Future<void> deleteFavorite(String bookId, String userId) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl?bookId=$bookId&userId=$userId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to remove from favorites');
    }
  }
}
