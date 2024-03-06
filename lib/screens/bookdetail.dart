import 'package:flutter/material.dart';
import 'package:oauth_frontend/models/book.dart';
import 'package:oauth_frontend/screens/cartscreen.dart';
import 'package:oauth_frontend/widgets/book_detail_item.dart';

class BookDetailsScreen extends StatefulWidget {
  final Book book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  bool isInCart = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
        actions: [
          IconButton(
            icon: isInCart
                ? const Icon(Icons.remove_shopping_cart)
                : const Icon(Icons.add_shopping_cart),
            onPressed: () {
              setState(() {
                isInCart = !isInCart;
                if (isInCart) {
                  // Aggiungi il libro al carrello
                  CartScreen.cartItems.add(widget.book);
                } else {
                  // Rimuovi il libro dal carrello
                  CartScreen.cartItems.remove(widget.book);
                }
              });
            },
          ),
        ],
      ),
      body: BookDetailItem( book: widget.book,)
    );
  }
}
