import 'package:bookshop_fe/providers/login.dart';
import 'package:bookshop_fe/services/backend_service.dart';
import 'package:flutter/material.dart';
import 'package:bookshop_fe/models/book.dart';
import 'package:provider/provider.dart';

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
    final lp = Provider.of<LoginProvider>(context);
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              flex: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: AspectRatio(
                  aspectRatio: 0.6,
                  child: Image.network(
                    widget.book.coverImageUrl,
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
              ),
            ),
            Flexible(
              flex: 1,
              child: Text('Title: ${widget.book.title}',
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold)),
            ),
            Flexible(
              flex: 1,
              child: Text('Author: ${widget.book.author}',
                  style: const TextStyle(fontSize: 14.0)),
            ),
            Flexible(
              flex: 2,
              child: IconButton(
                icon: isInWishlist
                    ? const Icon(Icons.favorite_border)
                    : const Icon(Icons.favorite_outlined),
                onPressed: () {
                  if (isInWishlist) {
                    BackendService.removeFromWishlist(
                        lp.accessToken, widget.book.id);
                  } else {
                    BackendService.addToWishlist(lp.accessToken, widget.book.id);
                  }
                  setState(() {
                    isInWishlist = !isInWishlist;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
