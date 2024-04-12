import 'package:bookshop_fe/providers/login.dart';
import 'package:bookshop_fe/screens/admin_page.dart';
import 'package:bookshop_fe/screens/cart_page.dart';
import 'package:bookshop_fe/screens/debug_page.dart';
import 'package:bookshop_fe/screens/profile_page.dart';
import 'package:bookshop_fe/screens/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:bookshop_fe/screens/browse_page.dart';
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
        '/browse': (context) => const BrowsePage(),
        '/profile': (context) => const ProfilePage(),
        '/wishlist' : (context) => const WishlistPage(),
        '/cart' : (context) => const CartPage(),
        '/debug' : (context) => const DebugPage(),
        '/admin' : (context) => AdminPage(),
      },
    );
  }
}
