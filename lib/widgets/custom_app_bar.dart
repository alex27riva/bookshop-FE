import 'package:bookshop_fe/providers/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onLoginPressed;
  final VoidCallback? onLogoutPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.onLoginPressed,
    this.onLogoutPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String user = context.watch<LoginProvider>().username;
    bool loggedIn = context.watch<LoginProvider>().loggedIn;
    return AppBar(
      title: Text(
          loggedIn ? "Welcome $user to my bookshop" : "Welcome, please log-in"),
      actions: [
        if (!loggedIn)
          TextButton(
            onPressed: onLoginPressed,
            child: const Text("Login"),
          ),
        if (loggedIn)
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: onLogoutPressed,
          ),
      ],
    );
  }
}
