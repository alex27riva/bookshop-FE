import 'package:flutter/material.dart';
import 'package:bookshop_fe/models/book.dart';

class BookItem extends StatefulWidget {
  final Book book;

  const BookItem({super.key, required this.book});

  @override
  State<BookItem> createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  bool isInWishlist = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      width: 120,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  widget.book.coverImageUrl,
                  width: 80,
                  height: 130,
                  fit: BoxFit.cover,
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
              ),
              const SizedBox(height: 10),
              Text('Title: ${widget.book.title}',
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text('Author: ${widget.book.author}',
                  style: const TextStyle(fontSize: 14.0)),
              const SizedBox(height: 10),
              IconButton(
                icon: isInWishlist ? const Icon(Icons.favorite_border) : const Icon(Icons.favorite_outlined),
                onPressed: () {
                  setState(() {
                    isInWishlist = !isInWishlist;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
