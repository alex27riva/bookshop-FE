import 'package:flutter/material.dart';
import 'package:bookshop_fe/screens/booklist.dart';
import 'package:bookshop_fe/screens/welcome.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bookshop',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/browse': (context) => const BookListScreen(),
        '/redirect': (context) => const WelcomeScreen(),
      },
    );
  }
}
