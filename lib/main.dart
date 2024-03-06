import 'package:flutter/material.dart';
import 'package:oauth_frontend/screens/booklist.dart';
import 'package:oauth_frontend/screens/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const SignUpScreen(),
        '/welcome': (context) => BookListScreen(),
      },
    );
  }
}
