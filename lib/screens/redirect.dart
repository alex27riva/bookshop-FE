// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:bookshop_fe/constants/oauth_config.dart';

class KeycloakRedirectPage extends StatefulWidget {
  final Function(String) onTokenReceived;
  String _uri = "";
  String _code = "";

  KeycloakRedirectPage({super.key, required this.onTokenReceived});

  @override
  _KeycloakRedirectPageState createState() => _KeycloakRedirectPageState();
}

class _KeycloakRedirectPageState extends State<KeycloakRedirectPage> {
  @override
  void initState() {
    super.initState();
    _handleRedirect();
  }

  Future<void> _handleRedirect() async {
    // Extract token from the redirect URI
    Uri uri = Uri.parse(html.window.location.href);
    widget._uri = uri.toString();
    String? code = uri.queryParameters['code'];
    widget._code = code.toString();

    // Notify the parent widget with the received token
    widget.onTokenReceived(code!);

    // Send the token to the Flask backend
    try {
      await sendCodeToBackend(code);
    } catch (e) {
      print('Error sending token to backend: $e');
      // Handle error
    }
  }

  Future<void> sendCodeToBackend(String code) async {
    final url = Uri.parse(OauthConfig.callbackUri);
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'code': code});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Token sent successfully to backend');
    } else {
      print('Failed to send token to backend: ${response.statusCode}');
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
