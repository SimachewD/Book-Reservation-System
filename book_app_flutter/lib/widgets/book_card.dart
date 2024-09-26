import 'package:flutter/material.dart';
import 'package:book_app_flutter/views/book_detail.dart';

class BookCard extends StatefulWidget {
  final String bookId;
  final String title;
  final String author;
  final String coverImage;
  final String status;

  const BookCard(
      {super.key,
      required this.bookId,
      required this.title,
      required this.author,
      required this.coverImage,
      required this.status});

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetail(
                bookId: widget.bookId,
              ),
            ),
          );
        },
        child: Card(
          elevation: 4, //card shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          child: Stack(children: [
            Padding(
              padding:
                  const EdgeInsets.all(2.0), // Adds padding inside the card
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to the left
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: Image.network(
                        'http://localhost:10000/my_library/api/uploads/${widget.coverImage}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.book,
                            size: 48,
                            color: Colors.grey,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 4), //space between the image and text
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 24, 42, 68),
                    ),
                    overflow: TextOverflow
                        .ellipsis, // Adds ellipsis if text overflows
                    maxLines: 1,
                  ),
                  Text(
                    'By: ${widget.author}',
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.grey[800],
                    ),
                    overflow: TextOverflow
                        .ellipsis, // Adds ellipsis if text overflows
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            if (widget.status != 'normal')
              Positioned(
                left: 0,
                top: 0,
                child: _buildBadge(widget.status),
              ),
            Positioned(
              right: -14, // Reduced to bring closer to the right edge
              top: -15, // Reduced to bring closer to the top edge
              child: IconButton(
                icon: const Icon(Icons.favorite),
                color: isFavorite ? Colors.red : Colors.grey,
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
              ),
            ),
          ]),
        ));
  }

  // Inline badge widget inside BookCard
  Widget _buildBadge(String status) {
    return Transform.rotate(
      angle: -0.5, // Slight rotation for the badge to appear diagonal
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.blue[900], // Badge background color
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          status == 'new release' ? 'NEW' : status.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 8,
          ),
        ),
      ),
    );
  }
}
