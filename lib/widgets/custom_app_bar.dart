import 'package:bookshop_fe/providers/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback? onLoginPressed;
  final VoidCallback? onLogoutPressed;

  const CustomAppBar({
    super.key,
    this.onLoginPressed,
    this.onLogoutPressed,
  });

  @override
  Widget build(BuildContext context) {
    String user = context.watch<LoginProvider>().username;
    bool loggedIn = context.watch<LoginProvider>().loggedIn;
    bool admin =
        context.watch<LoginProvider>().currentUser.roles.contains("admin");
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(loggedIn
              ? "Welcome to my bookshop, $user"
              : "Welcome, please log-in"),
          admin ? const Icon(Icons.admin_panel_settings_outlined) : Container(),
        ],
      ),
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
