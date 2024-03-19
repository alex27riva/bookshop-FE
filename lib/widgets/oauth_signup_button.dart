import 'package:flutter/material.dart';

class OAuthSignupButton extends StatelessWidget {
  const OAuthSignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/login');
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
        backgroundColor: Colors.blue,
      ),
      child: Container(
        width: 250,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo a sinistra
            Image.asset(
              'assets/unimi-logo.jpg',
              height: 30.0,
              width: 30.0,
            ),
            const SizedBox(width: 10.0),
            const Text(
              'Signup with UnimiID',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
