import 'package:flutter/material.dart';
import 'package:bookshop_fe/models/book.dart';
import 'package:bookshop_fe/screens/cartscreen.dart';

class BookDetailsScreen extends StatefulWidget {
  final Book book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  BookDetailsScreenState createState() => BookDetailsScreenState();
}

class BookDetailsScreenState extends State<BookDetailsScreen> {
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
      body: Container(), //BookDetailItem( book: widget.book,)
    );
  }
}
