import 'package:bdaya_shared_value/bdaya_shared_value.dart';
import 'package:bookshop_fe/providers/login.dart';
import 'package:bookshop_fe/screens/admin_page.dart';
import 'package:bookshop_fe/screens/browse_page.dart';
import 'package:bookshop_fe/screens/debug_page.dart';
import 'package:bookshop_fe/screens/home_page.dart';
import 'package:bookshop_fe/screens/profile_page.dart';
import 'package:bookshop_fe/screens/wishlist_page.dart';
import 'package:bookshop_fe/utils/app_state.dart' as app_state;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  setPathUrlStrategy();
  await dotenv.load(fileName: ".env");
  runApp(SharedValue.wrapApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LoginProvider())],
      child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Bookshop',
          theme: ThemeData(useMaterial3: true),
          routerConfig: GoRouter(routes: [
            GoRoute(path: '/', builder: (context, state) => const HomePage()),
            GoRoute(
                path: '/browse',
                builder: (context, state) => const BrowsePage()),
            GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfilePage()),
            GoRoute(
                path: '/wishlist',
                builder: (context, state) => const WishlistPage()),
            GoRoute(
                path: '/debug', builder: (context, state) => const DebugPage()),
            GoRoute(
                path: '/admin', builder: (context, state) => const AdminPage()),
          ]),
          builder: (context, child) {
            return FutureBuilder(
                future: app_state.initApp(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Container(
                            padding: const EdgeInsets.all(16),
                            child: const Text(
                              "Error connecting to Keycloak",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    );
                  }
                  return child!;
                });
          }),
    ),
  ));
}
