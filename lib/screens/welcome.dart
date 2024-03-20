import 'package:flutter/material.dart';
import 'package:bookshop_fe/screens/redirect.dart';
import 'package:bookshop_fe/widgets/oauth_signup_button.dart';

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
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  'assets/bookshop.jpg',
                  width: 500.0, // set the width
                  height: 200.0, // set the height
                  fit: BoxFit.fitWidth,
                ),
              ),
              const Divider(),
              TextButton(
                  onPressed: () => Navigator.of(context).pushNamed('/browse'),
                  child: const Text("Browse")),
              const OAuthSignupButton(),
              KeycloakRedirectPage(onTokenReceived: (String token) {
                print('Received token: $token');
              })
            ],
          ),
        ));
  }
}
