import 'package:flutter/material.dart';
import 'package:oauth_frontend/screens/booklist.dart';
import 'package:oauth_frontend/screens/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/browse': (context) => const BookListScreen(),
      },
    );
  }
}
