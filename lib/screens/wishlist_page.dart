import 'package:bookshop_fe/models/book.dart';
import 'package:bookshop_fe/providers/login.dart';
import 'package:bookshop_fe/services/backend_service.dart';
import 'package:bookshop_fe/widgets/custom_side_menu.dart';
import 'package:bookshop_fe/widgets/wishlist_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  WishlistPageState createState() => WishlistPageState();
}

class WishlistPageState extends State<WishlistPage> {
  List<Book> wishlistBooks = [];

  @override
  void initState() {
    super.initState();
    _fetchWishlist();
  }

  Future<void> _fetchWishlist() async {
    final lp = Provider.of<LoginProvider>(context, listen: false);
    wishlistBooks = await BackendService.fetchWishlist(lp.accessToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      drawer: const CustomSideMenu(),
      body: wishlistBooks.isEmpty
          ? const Center(child: Text('Your wishlist is empty'))
          : ListView.builder(
              itemCount: wishlistBooks.length,
              itemBuilder: (context, index) {
                return WishListTile(book: wishlistBooks[index]);
              },
            ),
    );
  }
}
