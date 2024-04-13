import 'package:bookshop_fe/models/book.dart';
import 'package:flutter/material.dart';

class AdminListTile extends StatelessWidget {
  final Book book;
  final VoidCallback onDelete;

  AdminListTile({required this.book, required this.onDelete})
      : super(key: ValueKey(book.id));

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(book.title),
      subtitle: Text('$book.author - \$${book.price.toStringAsFixed(2)}'),
      trailing: TextButton(
        onPressed: () {
          onDelete.call();
        },
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: const Text(
          "Delete",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
