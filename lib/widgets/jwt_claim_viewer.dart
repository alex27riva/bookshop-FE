import 'package:bookshop_fe/models/jwt_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JwtClaimViewer extends StatelessWidget {
  final String token;

  const JwtClaimViewer({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    JwtHelper jwt = JwtHelper(token);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 400),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ListTile(
              title: const Text("Full name"),
              subtitle: Text(jwt.fullName),
            ),
            ListTile(
              title: const Text("Email"),
              subtitle: Text(jwt.email),
            ),
            ListTile(
              title: const Text("Scopes"),
              subtitle: Text(jwt.scopes),
            ),
            ListTile(
              title: const Text("Roles"),
              subtitle: Text(jwt.roles.join(" ")),
            ),
            ListTile(
              title: const Text("Expiration"),
              subtitle: Text(
                jwt.expirationDate.toString(),
                style:
                    TextStyle(color: jwt.isValid() ? Colors.green : Colors.red),
              ),
            ),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: token));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('JWT token copied to clipboard')),
                );
              },
              child: ListTile(
                title: const Text("JWT token"),
                subtitle: Text(
                  token,
                  style: const TextStyle(fontSize: 12.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
