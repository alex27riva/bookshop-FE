import 'package:bookshop_fe/models/book.dart';
import 'package:flutter/material.dart';

class WishListTile extends StatelessWidget {
  final Book book;

  const WishListTile({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(book.coverImageUrl),
      title: Text(book.title),
      subtitle: Text(book.author),
      trailing: Text('\$${book.price.toStringAsFixed(2)}'),
      onTap: () {},
    );
  }
}
