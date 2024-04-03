import 'package:bookshop_fe/models/book.dart';
import 'package:bookshop_fe/widgets/custom_side_menu.dart';
import 'package:flutter/material.dart';

class WishlistItem {
  final Book book;
  WishlistItem(this.book);
}

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  WishlistPageState createState() => WishlistPageState();
}

class WishlistPageState extends State<WishlistPage> {
  List<WishlistItem> wishlistItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      drawer: const CustomSideMenu(),
      body: ListView.builder(
        itemCount: wishlistItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(wishlistItems[index].book.coverImageUrl),
            title: Text(wishlistItems[index].book.title),
            subtitle: Text(wishlistItems[index].book.author),
            //trailing: Text('\$${wishlistItems[index].book.price.toStringAsFixed(2)}'),
            onTap: () {
              // Implement action when tapping on a wishlist item
            },
          );
        },
      ),
    );
  }
}
