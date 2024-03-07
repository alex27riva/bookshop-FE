import 'package:flutter/material.dart';
import 'package:oauth_frontend/widgets/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
            child: SizedBox(
          width: 400,
          child: Card(
              child: Column(children: [
            const SignUpForm(),
            const Divider(),
            TextButton(onPressed: () {}, child: const Text("Signup with Oauth"))
          ])),
        )));
  }
}
