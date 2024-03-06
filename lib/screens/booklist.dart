import 'package:flutter/material.dart';
import 'package:oauth_frontend/models/book.dart';
import 'package:oauth_frontend/screens/cartscreen.dart';
import 'package:oauth_frontend/widgets/bookItem.dart';

class BookListScreen extends StatelessWidget {
  final List<Book> books = [
    Book('1984', 'George Orwell',
        'https://unlibrodaconsigliare.it/wp-content/uploads/2020/11/1984-199x300.jpg'),
    Book('Brave New World', 'Aldous Huxley',
        'https://i.pinimg.com/originals/d6/72/b6/d672b6e7275ca2ec2490149c57acc6b6.jpg'),
  ];

  BookListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return BookItem(book: books[index]);
        },
      ),
    );
  }
}
