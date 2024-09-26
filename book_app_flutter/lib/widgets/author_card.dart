import 'package:book_app_flutter/views/author_detail.dart';
import 'package:flutter/material.dart';
import 'package:book_app_flutter/models/author.dart';

class AuthorCard extends StatelessWidget {
  final Author author;

  const AuthorCard({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
        return InkWell(
        onTap: () {
              // Navigate to author details page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AuthorDetail(author: author),
                ),
              );
            },
        child: Card(
          elevation: 0, //card shadow
          child: Padding(
            padding: const EdgeInsets.all(2.0), // Adds padding inside the card
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment:CrossAxisAlignment.start, // Align text to the left
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const CircleAvatar(
                          child: Icon(Icons.person),),
                          Text( 
                            author.name,
                            style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 24, 42, 68), fontWeight: FontWeight.bold), 
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Text('Books: ${author.books.length}', style: TextStyle(color: Colors.grey[800]), overflow: TextOverflow.ellipsis, maxLines: 1,),
                    Text('Popularity Score: ${author.popularityScore}', style: TextStyle(color: Colors.grey[800]), overflow: TextOverflow.ellipsis, maxLines: 1,),
                    const SizedBox(height: 16,),
                  ],
                ),
                const Positioned(
                  bottom: 0, // Aligns the arrow to the bottom right
                  right: 0,
                  child: Row(
                    children: [
                      Text("Visit"),
                      Icon(
                        Icons.arrow_forward,
                        color: Color.fromARGB(255, 24, 42, 68),
                      ),
                    ],
                  ),
                ),
              ]  
            ),
          ),
        )
      );
    }
  }

