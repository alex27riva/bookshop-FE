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
  late Future<List<Book>> _fetchWishlist;

  @override
  void initState() {
    super.initState();
    _fetchWishlist = fetchWishlistData();
  }

  Future<List<Book>> fetchWishlistData() async {
    final lp = Provider.of<LoginProvider>(context, listen: false);
    return BackendService.fetchWishlist(lp.accessToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      drawer: const CustomSideMenu(),
      body: FutureBuilder<List<Book>>(
        future: _fetchWishlist,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(child: Text('Your wishlist is empty'));
          } else {
            final wishlistBooks = snapshot.data!;
            return ListView.builder(
              itemCount: wishlistBooks.length,
              itemBuilder: (context, index) {
                return WishListTile(book: wishlistBooks[index]);
              },
            );
          }
        },
      ),
    );
  }
}
