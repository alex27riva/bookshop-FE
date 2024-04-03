import 'package:flutter/material.dart';

class CustomSideMenu extends Drawer {
  const CustomSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Bookshop menu'),
          ),
          ListTile(
            title: const Text('Browse'),
            leading: const Icon(Icons.travel_explore),
            onTap: () => Navigator.pushNamed(context, '/browse'),
          ),
          ListTile(
            title: const Text('Profile'),
            leading: const Icon(Icons.person),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Wishlist'),
            leading: const Icon(Icons.favorite),
            onTap: () => Navigator.pushNamed(context, '/wishlist'),
          ),
          ListTile(
            title: const Text('Shopping cart'),
            leading: const Icon(Icons.shopping_cart_outlined),
            onTap: () => Navigator.pushNamed(context, '/cart'),
          ),
        ],
      ),
    );
  }
}
