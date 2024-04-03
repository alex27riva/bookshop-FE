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
            onTap: () => Navigator.pushNamed(context, '/browse'),
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Whishlist'),
            onTap: () => Navigator.pushNamed(context, '/wishlist'),
          ),
          ListTile(
            title: const Text('Shopping cart'),
            onTap: () => Navigator.pushNamed(context, '/cart'),
          ),
        ],
      ),
    );
  }
}
