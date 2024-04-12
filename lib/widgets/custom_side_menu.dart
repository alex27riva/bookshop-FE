import 'package:bookshop_fe/providers/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomSideMenu extends Drawer {
  const CustomSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final lp = Provider.of<LoginProvider>(context);
    bool loggedIn = lp.currentUser.loggedIn;
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
            title: const Text('Home'),
            leading: const Icon(Icons.home),
            onTap: () => Navigator.pushNamed(context, '/'),
          ),
          ListTile(
            title: const Text('Admin'),
            leading: const Icon(Icons.admin_panel_settings),
            onTap: () => Navigator.pushNamed(context, '/admin'),
          ),
          ListTile(
            title: const Text('Browse'),
            leading: const Icon(Icons.travel_explore),
            onTap: () => Navigator.pushNamed(context, '/browse'),
          ),
          loggedIn
              ? ListTile(
                  title: const Text('Profile'),
                  leading: const Icon(Icons.person),
                  onTap: () => Navigator.pushNamed(context, '/profile'),
                )
              : Container(),
          loggedIn
              ? ListTile(
                  title: const Text('Wishlist'),
                  leading: const Icon(Icons.favorite),
                  onTap: () => Navigator.pushNamed(context, '/wishlist'),
                )
              : Container(),
          // ListTile(
          //   title: const Text('Shopping cart'),
          //   leading: const Icon(Icons.shopping_cart_outlined),
          //   onTap: () => Navigator.pushNamed(context, '/cart'),
          // ),
          ListTile(
            title: const Text('Debug'),
            leading: const Icon(Icons.perm_device_information),
            onTap: () => Navigator.pushNamed(context, '/debug'),
          ),
        ],
      ),
    );
  }
}
