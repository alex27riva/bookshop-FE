import 'package:bookshop_fe/models/book.dart';
import 'package:bookshop_fe/services/backend_service.dart';
import 'package:bookshop_fe/widgets/admin_list_tile.dart';
import 'package:bookshop_fe/widgets/custom_side_menu.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<Book> books = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin page'),
      ),
      drawer: const CustomSideMenu(),
      body: FutureBuilder<List<Book>>(
        future: BackendService.fetchBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            books = snapshot.data!;
            return ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return AdminListTile(
                    book: book,
                    onDelete: () => _handleDeleteBook(book.id),
                  );
                });
          }
        },
      ),
    );
  }

  void _handleDeleteBook(int bookId) {
    // Remove book from the list
    setState(() {
      books.removeWhere((book) => book.id == bookId);
      BackendService.adminBookDelete(bookId); // Call backend service
    });
  }
}
