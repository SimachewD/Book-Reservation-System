import 'package:flutter/material.dart';
import 'package:book_app_flutter/models/book.dart';
import 'package:book_app_flutter/services/book_service.dart';
import 'package:book_app_flutter/widgets/book_card.dart';

class ReservedBooks extends StatefulWidget {
  const ReservedBooks({super.key});

  @override
  State<ReservedBooks> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ReservedBooks> {

  late Future<List<Book>> futureBooks;

  @override
  void initState() {
    super.initState();
    futureBooks = BookService.getAllBooks(); // Initialize fetching books
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 8.0, // Space between columns
                    mainAxisSpacing: 8.0, // Space between rows
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
                }

              // show a loading spinner.
                return const CircularProgressIndicator();

                }
                ),
            
        ],
      )
    );
  }
}




