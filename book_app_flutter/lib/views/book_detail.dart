import 'package:book_app_flutter/providers/auth_provider.dart';
import 'package:book_app_flutter/widgets/buy_book_form.dart';
import 'package:book_app_flutter/widgets/reserve_book_form.dart';
import 'package:flutter/material.dart';
import 'package:book_app_flutter/models/book.dart';
import 'package:book_app_flutter/services/book_service.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BookDetail extends StatefulWidget {
  final String bookId;

  const BookDetail({super.key, required this.bookId});

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  late Future<Book?> futureBook;

  @override
  void initState() {
    super.initState();
    futureBook = BookService.getBookDetails(widget.bookId);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context);
    final token = user.token.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details',
            style: TextStyle(fontWeight: FontWeight.w500)),
        backgroundColor: const Color.fromARGB(255, 1, 44, 80),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              user.logout();
            },
          ),
        ],
      ),
      body: FutureBuilder<Book?>(
        future: futureBook,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red, fontSize: 16)));
          } else if (snapshot.hasData) {
            final book = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          'http://localhost:10000/my_library/api/uploads/${book.coverImage}',
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Center(
                                child: Text(book.title,
                                    style: const TextStyle(
                                        fontSize: 24,
                                        color: Color.fromARGB(255, 1, 44, 80),
                                        fontWeight: FontWeight.w600))),
                            _buildDetailRow('Author:',
                                '${book.author} (${book.authorPopularityScore})'),
                            _buildDetailRow(
                                'Published on:',
                                DateFormat('MMMM dd, yyyy')
                                    .format(book.publicationDate)),
                            _buildDetailRow('Status:', book.status),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildActionButton('Buy', user.token != null
                                    ? () => showBuyBookModal(context, book)
                                    : (){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                         const SnackBar(content: Text('You must be logged in to make a purchase'))
                                      );
                                    }
                                ),
                                _buildActionButton(
                                    'Reserve', user.token != null
                                    ? () => showReserveBookModal(
                                        context, user.id!, token, book)
                                    : (){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                         const SnackBar(content: Text('You must be logged in to make a reservation'))
                                      );
                                    }    
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('No book data available'));
          }
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(width: 8),
          Expanded(
              child: Text(value,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]))),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 1, 44, 80),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }
}
