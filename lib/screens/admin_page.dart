import 'package:bookshop_fe/models/book.dart';
import 'package:bookshop_fe/services/backend_service.dart';
import 'package:bookshop_fe/widgets/custom_side_menu.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    //Book book = Book.fromJson(widget.data[0]);

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
            final books = snapshot.data!;
            return ListView.builder(
                itemCount: books.length, itemBuilder: (context,index) {
                  final book = books[index];
                  return book.toListTile();;
            });
          }
        },
      ),

    );
  }
}
