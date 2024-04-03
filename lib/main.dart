import 'package:bookshop_fe/providers/login.dart';
import 'package:bookshop_fe/screens/cartscreen.dart';
import 'package:bookshop_fe/screens/profile_page.dart';
import 'package:bookshop_fe/screens/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:bookshop_fe/screens/booklist.dart';
import 'package:bookshop_fe/screens/home_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => LoginProvider())],
    child: const MyApp(),
  ));
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
        '/': (context) => const HomePage(),
        '/browse': (context) => const BookListScreen(),
        '/profile': (context) => const ProfilePage(),
        '/wishlist' : (context) => const WishlistPage(),
        '/cart' : (context) => const CartScreen(),
      },
    );
  }
}
