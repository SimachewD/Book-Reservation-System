import 'package:flutter/material.dart';
import 'package:book_app_flutter/models/book.dart';
import 'package:book_app_flutter/services/book_service.dart';
import 'package:book_app_flutter/widgets/book_card.dart';

class FeaturedBooks extends StatefulWidget {
  const FeaturedBooks({super.key});

  @override
  State<FeaturedBooks> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FeaturedBooks> {

  late Future<List<Book>> futureBooks;

  @override
  void initState() {
    super.initState();
    futureBooks = BookService.getFeaturedBooks(); // Initialize fetching books
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Featured Books',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        FutureBuilder<List<Book>>(
        future: futureBooks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString().split(': ').last, style: const TextStyle(color:Colors.red),));
            
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No books available'));

          } else if(snapshot.hasData) {
            final books = snapshot.data!;
              return GridView.builder(
                shrinkWrap: true, // Ensures GridView occupies only the space it needs
                physics: const NeverScrollableScrollPhysics(), // Disable internal scroll of GridView
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 100, // Set the maximum width for each BookCard
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  ),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return BookCard(
                    bookId: book.id,
                    title: book.title,
                    author: book.author,
                    coverImage: book.coverImage,
                    status: book.status,
                  );
                }
                );
            } else {
                return const Center(child: Text('Unknown Error'));
              }

          }
        ),
           
      ],
    );
  }
}




