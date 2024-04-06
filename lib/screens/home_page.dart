import 'package:bookshop_fe/models/jwt_helper.dart';
import 'package:bookshop_fe/providers/login.dart';
import 'package:bookshop_fe/services/pkce_auth.dart';
import 'package:bookshop_fe/services/secure_storage.dart';
import 'package:bookshop_fe/widgets/custom_app_bar.dart';
import 'package:bookshop_fe/widgets/custom_side_menu.dart';
import 'package:flutter/material.dart';
import 'package:openid_client/openid_client.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _accessToken = "";

  Future<void> _handleLogin() async {
    final lp = Provider.of<LoginProvider>(context, listen: false);

    Credential result = await PKCEAuth.authenticateWeb();
    var tokenResponse = await result.getTokenResponse();
    if (tokenResponse.accessToken != null) {
      _accessToken = tokenResponse.accessToken!;
      lp.login(_accessToken);
      SecureStorage.setAccessToken(tokenResponse.accessToken);
    }
  }

  void _handleLogout() {
    final lp = Provider.of<LoginProvider>(context, listen: false);
    _accessToken = "";
    lp.logout();
  }

  Future<void> _loadToken() async {
    final lp = Provider.of<LoginProvider>(context, listen: false);
    _accessToken = await SecureStorage.getAccessToken();
    if (_accessToken.isNotEmpty) {
      final jwt = JwtHelper(_accessToken);
      if (jwt.isValid()) {
        lp.login(_accessToken);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  @override
  Widget build(BuildContext context) {
    // keep this
    Provider.of<LoginProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: CustomAppBar(
              onLoginPressed: () => _handleLogin(),
              onLogoutPressed: () => _handleLogout()),
        ),
        drawer: const CustomSideMenu(),
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
            ],
          ),
        ));
  }
}
