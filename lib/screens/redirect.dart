// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bookshop_fe/models/token_response.dart';
import 'package:bookshop_fe/utils/environment.dart';
import 'package:bookshop_fe/utils/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class KeycloakRedirectPage extends StatefulWidget {
  final Function(String) onTokenReceived;
  String _uri = "";
  String _code = "";

  KeycloakRedirectPage({super.key, required this.onTokenReceived});

  @override
  KeycloakRedirectPageState createState() => KeycloakRedirectPageState();
}

class KeycloakRedirectPageState extends State<KeycloakRedirectPage> {
  @override
  void initState() {
    super.initState();
    _handleRedirect();
  }

  void _showSnackbarError(BuildContext context, String error) async {
    if (!context.mounted) return;
    // Display error in a Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: $error'),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> _handleRedirect() async {
    // Extract token from the redirect URI
    Uri uri = Uri.parse(html.window.location.href);
    widget._uri = uri.toString();
    String? code = uri.queryParameters['code'];
    widget._code = code.toString();

    // Notify the parent widget with the received token
    widget.onTokenReceived(code!);

    // Send the auth_code to the Flask backend
    try {
      await sendCodeToBackend(code);
    } catch (e) {
      print('Error sending code to backend: $e');
      // Handle error
    }
  }

  Future<void> sendCodeToBackend(String code) async {
    final url = Uri.parse(Environment.backendCallbackUri);
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'code': code});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Code sent successfully to backend');
      final jsonResponse = jsonDecode(response.body);
      final tokenResponse = TokenResponse.fromJson(jsonResponse);
      // Store token
      SecureStorage.storeToken(tokenResponse.accessToken);

      //TODO: Remove print
      print(tokenResponse.accessToken);
    } else {
      print('Failed to send code to backend: ${response.statusCode}');
      // ignore: use_build_context_synchronously
      _showSnackbarError(context, response.body);
      // Handle failure
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(widget._uri),
          Text(
            widget._code,
            style: const TextStyle(color: Colors.red),
          )
        ],
      ),
    );
  }
}
