import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bookshop_fe/constants/urls.dart';
import 'package:bookshop_fe/models/book.dart';
import 'package:bookshop_fe/screens/cartscreen.dart';
import 'package:bookshop_fe/widgets/book_item.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

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
    try {
      final response = await http.get(Uri.parse(Urls.booksEndpoint));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data.map((item) => Book.fromJson(item)).toList();
      } else {
        // Handle other errors (non-client exceptions)
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on ClientException catch (e) {
      // Handle ClientExceptions (e.g., network errors)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Network error! Check your connection.'),
          backgroundColor: Colors.red,
        ),
      );
      return [];
    } catch (e) {
      // Handle other unexpected exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An unexpected error occurred.'),
          backgroundColor: Colors.red,
        ),
      );
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
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // number of columns,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
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
