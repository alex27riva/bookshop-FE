import 'package:bookshop_fe/providers/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback? onLoginPressed;
  final VoidCallback? onLogoutPressed;

  const CustomAppBar({
    Key? key,
    this.onLoginPressed,
    this.onLogoutPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String user = context.watch<LoginProvider>().username;
    bool loggedIn = context.watch<LoginProvider>().loggedIn;
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
          loggedIn ? "$user, welcome to my bookshop" : "Welcome, please log-in"),
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
