import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oauth_frontend/models/book.dart';
import 'package:oauth_frontend/screens/cartscreen.dart';
import 'package:oauth_frontend/widgets/bookItem.dart';
import 'package:http/http.dart' as http;

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<List<Book>> fetchData() async {
    final response =
        await http.get(Uri.parse('http://localhost:5000/api/books'));

    if (response.statusCode == 200) {
      // Parse the JSON response
      final List<dynamic> data = jsonDecode(response.body);

    return data.map((item) {
      return Book(
        item['title'],
        item['author'],
        item['cover_image_url'],
      );
    }).toList();
    } else {
      // Handle errors
      print('Failed to load data: ${response.statusCode}');
      return [];
    }
  }

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
                  builder: (context) => const CartScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Book>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return BookItem(book: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}
