import 'package:flutter/material.dart';
import 'package:oauth_frontend/widgets/oauth_signup_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Welcome to my bookshop!"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/bookshop.jpg',
                width: 500.0, // set the width
                height: 200.0, // set the height
                fit: BoxFit.fitWidth,
              ),
              const Divider(),
              TextButton(
                  onPressed: () => Navigator.of(context).pushNamed('/signup'),
                  child: const Text("SignIn")),
              TextButton(
                  onPressed: () => Navigator.of(context).pushNamed('/welcome'),
                  child: const Text("Login")),
              const OAuthSignupButton(),
            ],
          ),
        ));
  }
}
