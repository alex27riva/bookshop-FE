import 'package:bookshop_fe/models/book.dart';
import 'package:bookshop_fe/providers/login.dart';
import 'package:bookshop_fe/services/backend_service.dart';
import 'package:flutter/material.dart';
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
    final scaffoldMessengerState = ScaffoldMessenger.of(context);
    var loggedIn = lp.currentUser.loggedIn;
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
                  child: FadeInImage(
                    image: NetworkImage(widget.book.coverImageUrl),
                    placeholder:
                        const AssetImage('assets/book-cover-placeholder.png'),
                  ),
                ),
              ),
            ),
            // Book title
            Flexible(
              flex: 1,
              child: Text(widget.book.title,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold)),
            ),
            // Book Author
            Flexible(
              flex: 1,
              child: Text(widget.book.author,
                  style: const TextStyle(fontSize: 12.0)),
            ),
            Flexible(
              flex: 1,
              child: Text('${widget.book.price.toString()} \$',
                  style: const TextStyle(fontSize: 12.0)),
            ),
            loggedIn
                ? Flexible(
                    flex: 2,
                    child: IconButton(
                      icon: !isInWishlist
                          ? const Icon(Icons.favorite_border)
                          : const Icon(Icons.favorite_outlined),
                      onPressed: () async {
                        if (!isInWishlist) {
                          var resp = await BackendService.addToWishlist(
                              lp.accessToken, widget.book.id);
                          if (resp.statusCode == 201) {
                            scaffoldMessengerState.showSnackBar(
                              const SnackBar(
                                content: Text('Added to wishlist'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                            setState(() {
                              isInWishlist = true;
                            });
                          } else if (resp.statusCode == 200) {
                            scaffoldMessengerState.showSnackBar(const SnackBar(
                              content: Text('Item already in user wishlist'),
                              duration: Duration(seconds: 1),
                            ));
                            setState(() {
                              isInWishlist = true;
                            });
                          }
                        } else {
                          var resp = await BackendService.removeFromWishlist(
                              lp.accessToken, widget.book.id);
                          if (resp.statusCode == 200) {
                            scaffoldMessengerState.showSnackBar(
                              const SnackBar(
                                content: Text('Book removed from wishlist'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                            setState(() {
                              isInWishlist = false;
                            });
                          }
                        }
                      },
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
