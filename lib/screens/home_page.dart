import 'package:bookshop_fe/models/jwt_helper.dart';
import 'package:bookshop_fe/providers/login.dart';
import 'package:bookshop_fe/services/secure_storage.dart';
import 'package:bookshop_fe/utils/app_state.dart' as app_state;
import 'package:bookshop_fe/widgets/custom_app_bar.dart';
import 'package:bookshop_fe/widgets/custom_side_menu.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oidc/oidc.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _accessToken = "";
  OidcPlatformSpecificOptions_Web_NavigationMode webNavigationMode =
      OidcPlatformSpecificOptions_Web_NavigationMode.newPage;

  OidcPlatformSpecificOptions _getOptions() {
    return OidcPlatformSpecificOptions(
      web: OidcPlatformSpecificOptions_Web(
        navigationMode: webNavigationMode,
        popupHeight: 800,
        popupWidth: 730,
      ),
    );
  }

  Future<void> _handleLogin() async {
    final lp = Provider.of<LoginProvider>(context, listen: false);

    final messenger = ScaffoldMessenger.of(context);
    try {
      final currentRoute = GoRouterState.of(context);
      final originalUri =
          currentRoute.uri.queryParameters[OidcConstants_Store.originalUri];
      final parsedOriginalUri =
          originalUri == null ? null : Uri.tryParse(originalUri);
      final result = await app_state.currentManager.loginAuthorizationCodeFlow(
        originalUri: parsedOriginalUri ?? Uri.parse('/'),
        //store any arbitrary data, here we store the authorization
        //start time.
        extraStateData: DateTime.now().toIso8601String(),
        options: _getOptions(),
        //NOTE: you can pass more parameters here.
      );

      if (result?.token.accessToken != null) {
        _accessToken = result!.token.accessToken!;
        lp.login(result.token.accessToken);
      }

      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            'Authentication successful',
          ),
        ),
      );
    } catch (e) {
      app_state.logger.severe(e.toString());
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'loginAuthorizationCodeFlow failed! ${e is OidcException ? e.message : ""}',
          ),
        ),
      );
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
                  onPressed: () => GoRouter.of(context).go('/browse'),
                  child: const Text("Browse")),
            ],
          ),
        ));
  }
}
