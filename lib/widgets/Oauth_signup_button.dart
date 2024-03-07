import 'package:flutter/material.dart';

class OAuthSignupButton extends StatelessWidget {
  const OAuthSignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Aggiungi qui la logica di gestione dell'accesso con OAuth
        // Quando il pulsante viene premuto
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
        backgroundColor: Colors.blue,
      ),
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
    );
  }
}
