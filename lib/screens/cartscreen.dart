import 'package:flutter/material.dart';
import 'package:bookshop_fe/models/book.dart';

class CartScreen extends StatelessWidget {
  static List<Book> cartItems = [];

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrello'),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('The cart is empty.'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(cartItems[index].title),
                  subtitle: Text(cartItems[index].author),
                );
              },
            ),
    );
  }
}
