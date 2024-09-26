import 'package:flutter/material.dart';
import 'package:book_app_flutter/models/author.dart';

class AuthorDetail extends StatelessWidget {
  final Author author;

  const AuthorDetail({super.key, required this.author});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Author Details'),
        backgroundColor: const Color.fromARGB(255, 1, 44, 80),
        foregroundColor: Colors.white,
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              author.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Popularity Score: ${author.popularityScore}'),
            const SizedBox(height: 16),
            const Text(
              'Books:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: author.books.length,
                itemBuilder: (context, index) {
                  final book = author.books[index];
                  return ListTile(
                    title: Text(book.title),
                    subtitle: Text('Status: ${book.status}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
