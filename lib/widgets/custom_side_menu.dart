import 'package:bookshop_fe/providers/login.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CustomSideMenu extends Drawer {
  const CustomSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final lp = Provider.of<LoginProvider>(context);
    bool loggedIn = lp.currentUser.loggedIn;
    bool admin = lp.currentUser.admin;
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
            onTap: () => GoRouter.of(context).go('/'),
          ),
          admin
              ? ListTile(
                  title: const Text('Admin'),
                  leading: const Icon(Icons.admin_panel_settings),
                  onTap: () => GoRouter.of(context).go('/admin'),
                )
              : Container(),
          ListTile(
            title: const Text('Browse'),
            leading: const Icon(Icons.travel_explore),
            onTap: () => GoRouter.of(context).go('/browse'),
          ),
          loggedIn
              ? ListTile(
                  title: const Text('Profile'),
                  leading: const Icon(Icons.person),
                  onTap: () => GoRouter.of(context).go('/profile'),
                )
              : Container(),
          loggedIn
              ? ListTile(
                  title: const Text('Wishlist'),
                  leading: const Icon(Icons.favorite),
                  onTap: () => GoRouter.of(context).go('/wishlist'),
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
            onTap: () => GoRouter.of(context).go('/debug'),
          ),
        ],
      ),
    );
  }
}
