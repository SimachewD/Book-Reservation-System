// lib/models/book.dart
import 'package:book_app_flutter/models/author.dart';

class Book {
  final String id;
  final String title;
  final DateTime publicationDate;
  final String author;
  final int authorPopularityScore;
  final String status;
  final String coverImage;

  Book(
      {required this.id,
      required this.title,
      required this.publicationDate,
      required this.author,
      required this.authorPopularityScore,
      required this.status,
      required this.coverImage});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        id: json['_id'],
        title: json['title'],
        publicationDate: DateTime.parse(json['publicationDate']),
        author: Author.fromJson(json['author']).name,
        authorPopularityScore: Author.fromJson(json['author']).popularityScore,
        status: json['status'],
        coverImage: json['coverImage']);
  }

  get length => null;
}
