import 'package:flutter/material.dart';

class Book {
  final int id;
  final String title;
  final String author;
  final double price;
  final String coverImageUrl;

  Book(
      {this.id = -1,
      required this.title,
      required this.author,
      required this.price,
      required this.coverImageUrl});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
      price: json['price'] ?? 999.0,
      //high price if is null
      coverImageUrl: json['cover_image_url'] as String,
    );
  }

  Widget toListTile() {
    return ListTile(
      title: Text(title),
      subtitle: Text('$author - \$${price.toStringAsFixed(2)}'),
      trailing: TextButton(
        onPressed: () {},
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
