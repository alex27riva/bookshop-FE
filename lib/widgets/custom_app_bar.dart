import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String? username;
  final VoidCallback? onLoginPressed;
  final VoidCallback? onLogoutPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.username,
    this.onLoginPressed,
    this.onLogoutPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(username?.isEmpty ?? true ? title : "Welcome, $username"),
      actions: [
        if (username?.isEmpty ?? true)
          TextButton(
            onPressed: onLoginPressed,
            child: const Text("Login"),
          ),
        if (username != null)
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: onLogoutPressed,
          ),
      ],
    );
  }
}