import 'package:bookshop_fe/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:bookshop_fe/widgets/oauth_signup_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _username = "";

  void _handleLogin(String username) {
    setState(() {
      _username = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomAppBar(
            title: 'MyApp',
            username: _username,
            onLoginPressed: () => _handleLogin('Guest'),
            onLogoutPressed: () => setState(() => _username = ''),
          ),
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
            ],
          ),
        ));
  }
}
