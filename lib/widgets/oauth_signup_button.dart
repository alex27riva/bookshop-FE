import 'package:bookshop_fe/services/pkce_auth.dart';
import 'package:flutter/material.dart';

class OAuthSignupButton extends StatelessWidget {
  const OAuthSignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => PKCEAuth.authenticateWeb(),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
        backgroundColor: Colors.blue,
      ),
      child: SizedBox(
        width: 250,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/unimi-logo.jpg',
              height: 30.0,
              width: 30.0,
            ),
            const SizedBox(width: 10.0),
            const Text(
              'Signup with UnimiID',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
