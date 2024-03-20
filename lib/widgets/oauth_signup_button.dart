import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:bookshop_fe/constants/oauth_config.dart';

class OAuthSignupButton extends StatelessWidget {
  final String _clientId = OauthConfig.clientId;
  final String _redirectUriScheme = OauthConfig.redirectUriScheme;
  final String _redirectUriPath = OauthConfig.redirectUriPath;
  final String _authorizationEndpoint = OauthConfig.authorizationEndpoint;

  const OAuthSignupButton({super.key});

  Future<void> _login(BuildContext context) async {
    String authorizationUrl =
        '$_authorizationEndpoint?response_type=code&client_id=$_clientId&redirect_uri=$_redirectUriScheme://$_redirectUriPath';

    try {
      // Open Keycloak authentication URL in a browser
      final result = await FlutterWebAuth.authenticate(
          url: authorizationUrl, callbackUrlScheme: _redirectUriScheme);
      // ignore: avoid_print
      print(result); // Handle the authentication result
    } catch (e) {
      print('Error: $e');
      // Handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _login(context),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
        backgroundColor: Colors.blue,
      ),
      child: SizedBox(
        width: 250,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/unimi-logo.jpg',
              height: 30.0,
              width: 30.0,
            ),
            const SizedBox(width: 10.0),
            const Text(
              'Signup with UnimiID',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
