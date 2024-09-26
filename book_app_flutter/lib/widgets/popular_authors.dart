import 'package:book_app_flutter/models/author.dart';
import 'package:book_app_flutter/services/author_service.dart';
import 'package:book_app_flutter/widgets/author_card.dart';
import 'package:flutter/material.dart';

class PopularAuthors extends StatefulWidget {
  const PopularAuthors({super.key});

  @override
  State<PopularAuthors> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PopularAuthors> {

  late Future<List<Author>> futureAuthors;

  @override
  void initState() {
    super.initState();
    futureAuthors = AuthorService.getAllAuthors(); // Initialize fetching authors
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Popular Authors',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        FutureBuilder<List<Author>>(
        future: futureAuthors,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString().split(': ').last, style: const TextStyle(color:Colors.red),));
            
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No books available'));

          } else if(snapshot.hasData) {
            final authors = snapshot.data!.where((author) => author.popularityScore > 80).toList();
              return GridView.builder(
                shrinkWrap: true, // Ensures GridView occupies only the space it needs
                physics: const NeverScrollableScrollPhysics(), // Disable internal scroll of GridView
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200, 
                  crossAxisSpacing: 8.0, // Space between columns
                  mainAxisSpacing: 8.0, // Space between rows
                  mainAxisExtent: 130
                ),
                itemCount: authors.length,
                itemBuilder: (context, index) {
                  final author = authors[index];
              return AuthorCard(author:author);
                }
              );
            }
            // show a loading spinner.
              return const CircularProgressIndicator();

          }
        ),
           
      ],
    );
  }
}




