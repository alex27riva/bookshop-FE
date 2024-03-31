import 'package:bookshop_fe/providers/login.dart';
import 'package:bookshop_fe/services/pkce_auth.dart';
import 'package:bookshop_fe/services/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:openid_client/openid_client.dart';
import 'package:provider/provider.dart';

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
    String user = context.watch<Login>().getUsername;
    bool loggedIn = context.watch<Login>().isLoggedIn;
    return AppBar(
      title: Text(
          loggedIn ? "Welcome $user to my bookshop" : "Welcome, please log-in"),
      actions: [
        if (!loggedIn)
          TextButton(
            onPressed: () async {
              final login = Provider.of<Login>(context, listen: false);
              Credential result = await PKCEAuth.authenticateWeb();
              var tokenResponse = await result.getTokenResponse();
              if (tokenResponse.accessToken != null) {
                login.setAccessToken(tokenResponse.accessToken);
                SecureStorage.setAccessToken(tokenResponse.accessToken);
              }
            },
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
