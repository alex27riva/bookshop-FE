import 'package:flutter/material.dart';
import 'package:oauth_frontend/models/book.dart';

class BookDetailItem extends StatelessWidget {
  final Book book;

  const BookDetailItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.network(
            book.coverImageUrl,
            width: 200,
            height: 500,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              }
            },
          ),

          SizedBox(height: 10),
          Text('Title: ${book.title}', style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          Text('Author: ${book.author}', style: TextStyle(fontSize: 16)),
          // Add other book details here
        ],
      ),
    );
  }
}
