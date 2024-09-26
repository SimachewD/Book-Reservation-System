
class Author {
  final String id;
  final String name;
  final int popularityScore;
  final List<dynamic> books;

  Author({
    required this.id,
    required this.name,
    required this.books,
    required this.popularityScore,
  });

  factory Author.fromJson(Map<String, dynamic> json) {

    return Author(
      id: json['_id'],
      name: json['name'],
      books: json['books'],
      popularityScore: json['popularityScore'],
    );
  }
}
