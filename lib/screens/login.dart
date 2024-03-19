import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

class LoginScreen extends StatelessWidget {
  final String _clientId = 'flask-demo';
  final String _redirectUriScheme = 'http';
  final String _redirectUriPath = 'localhost:5000/api/callback';
  final String _authorizationEndpoint =
      'http://localhost:8080/auth/realms/unimi/protocol/openid-connect/auth';

  // final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  const LoginScreen({super.key});

Future<void> _login(BuildContext context) async {
    String authorizationUrl =
        '$_authorizationEndpoint?response_type=code&client_id=$_clientId&redirect_uri=$_redirectUriScheme://$_redirectUriPath';
    
    try {
      // Open Keycloak authentication URL in a browser
      final result = await FlutterWebAuth.authenticate(url: authorizationUrl, callbackUrlScheme: _redirectUriScheme);
      // ignore: avoid_print
      print(result); // Handle the authentication result
    } catch (e) {
      print('Error: $e');
      // Handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _login(context),
          child: const Text('Login with Keycloak'),
        ),
      ),
    );
  }
}
